extends Node2D

class_name OrderManager

var activeOrders : Array[Order] = [];
var orderScene = preload("res://scenes/order.tscn");

enum orderTypes {
	espresso,
	coffee,
	latte
}

func _on_place_order(customer : Customer):
	print("Placing order");
	var order = orderScene.instantiate();
	add_child(order);
	activeOrders.push_back(order);
	order.orderType = orderTypes.values().pick_random();
	defineOrderRequirements(order);
	order.customer = customer;
	order.position = customer.position;
	order.position.y -= 48;
	order.order_expired.connect(_on_order_expired);	
	order.order_fulfilled.connect(_on_order_fulfilled);	
	order.startOrderTimer();

func _on_order_fulfilled(order : Order):
	print("Order fulfilled");

func _on_order_expired(order : Order):
	print("Order Expired");	
	activeOrders.erase(order);
	order.customer.orderCompleted();
	order.queue_free();
	
func defineOrderRequirements(order : Order):
	#TODO: define requirements
	pass
