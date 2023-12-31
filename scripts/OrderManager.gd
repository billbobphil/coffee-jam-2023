extends Node2D

class_name OrderManager

var activeOrders : Array[Order] = [];
var orderScene = preload("res://scenes/order.tscn");
var validProductBases : Array[Product.productTypes];

signal payout_triggered;

enum orderTypes {
	espresso,
	coffee,
	latte
}

func _ready():
	validProductBases = [];
	validProductBases.push_back(Product.productTypes.coffee);
	validProductBases.push_back(Product.productTypes.espresso);

func _on_place_order(customer : Customer):
	print("Placing order");
	var order = orderScene.instantiate();
	add_child(order);
	activeOrders.push_back(order);
	var requiredOrder = Product.new();
	requiredOrder.type = validProductBases.pick_random();
	requiredOrder = defineOrderRequirements(requiredOrder);
	order.setRequiredOrder(requiredOrder);
	print(order.requiredOrder.type);
	print(order.requiredOrder.numberOfSugarAndCreamInCoffee);
	print(order.requiredOrder.espressoHasSteamedMilk);
	order.customer = customer;
	order.position = customer.position;
	order.position.y -= 48;
	order.order_expired.connect(_on_order_expired);	
	order.order_fulfilled.connect(_on_order_fulfilled);	
	order.payout_triggered.connect(_on_payout_triggered);
	order.startOrderTimer();

func _on_order_fulfilled(order : Order):
	print("Order fulfilled");

func _on_order_expired(order : Order):
	print("Order Expired");	
	activeOrders.erase(order);
	order.customer.orderCompleted();
	order.queue_free();
	payout_triggered.emit(-3);
	
func defineOrderRequirements(product : Product):
	if(product.type == Product.productTypes.coffee):
		var numberOfSugarAndCreamsOptions = [0, 1, 2];
		var actualNumber = numberOfSugarAndCreamsOptions.pick_random();
		product.numberOfSugarAndCreamInCoffee = actualNumber;
	elif(product.type == Product.productTypes.espresso):
		var steamedMilkOptions = [0, 1];
		var actual = steamedMilkOptions.pick_random();
		if(actual == 1):
			product.espressoHasSteamedMilk = true;
	return product;
	
func _on_payout_triggered(amount : float):
	payout_triggered.emit(amount);
