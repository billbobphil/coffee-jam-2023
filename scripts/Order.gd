extends Node2D

class_name Order

var coffeeZeroSprite = preload("res://art/coffee-zero-32x32.png");
var coffeeOneSprite = preload("res://art/coffee-one-32x32.png");
var coffeeTwoSprite = preload("res://art/coffee-two-32x32.png");
var latteSprite = preload("res://art/latte-32x32.png");
var espressoSprite = preload("res://art/espresso-black-32x32.png");

@export var orderTimeMax : float = 30;
var orderTimer : float = 0;
var isOrderTimerStarted : bool = false;
@export var yFloatMax : float = 4;
@export var yFloatMin : float = -4;
@export var floatIncrement : float = 10;
@export var basePayoutAmount : int = 10;
var shouldFloat : bool = false;
var initialPositionY : float;
var direction : int = 1;
var isOrderOnGoing : bool = false;
var customer : Customer;
var canOrderBeInteractedWith : bool = false;
var requiredOrder : Product;


signal order_expired;
signal order_fulfilled;
signal payout_triggered;

func _ready():
	var player = get_tree().get_first_node_in_group("Player")
	player.interaction_triggered.connect(_on_player_interaction_triggered);
	orderTimer = orderTimeMax;
	
func startOrderTimer():
	print("Order timer started");
	isOrderTimerStarted = true;
	isOrderOnGoing = true;
	shouldFloat = true;
	initialPositionY = position.y;
	print("Order type: " + str(requiredOrder.type));

func _process(delta):
	orderTimerRoutine(delta);
	floatRoutine(delta);
	
func setRequiredOrder(product : Product):
	requiredOrder = product;
	if(requiredOrder.type == Product.productTypes.espresso):
		if(requiredOrder.espressoHasSteamedMilk):
			get_node("OrderSprite").texture = latteSprite;
		else:
			get_node("OrderSprite").texture = espressoSprite;
	elif(requiredOrder.type == Product.productTypes.coffee):
		if(requiredOrder.numberOfSugarAndCreamInCoffee == 0):
			get_node("OrderSprite").texture = coffeeZeroSprite;
		elif(requiredOrder.numberOfSugarAndCreamInCoffee == 1):
			get_node("OrderSprite").texture = coffeeOneSprite;
		elif(requiredOrder.numberOfSugarAndCreamInCoffee == 2):
			get_node("OrderSprite").texture = coffeeTwoSprite;
		
	
func orderTimerRoutine(delta):
	if(isOrderTimerStarted && isOrderOnGoing):
		orderTimer -= delta;
		get_node("TimeRemainingBar").value = (orderTimer / orderTimeMax) * 100; 
		if(orderTimer <= 0):
			order_expired.emit(self);
			isOrderOnGoing = false;

func floatRoutine(delta):
	if(shouldFloat):
		position.y += (floatIncrement * delta) * direction;
		
	if(position.y >= initialPositionY + yFloatMax):
		direction = -1; 
		
	if(position.y <= initialPositionY + yFloatMin):
		direction = 1;

func _on_area_2d_body_entered(body):
	if(body.name == "Player"):
		get_node("InteractSprite").visible = true;
		canOrderBeInteractedWith = true;

func _on_area_2d_body_exited(body):
	if(body.name == "Player"):
		get_node("InteractSprite").visible = false;
		canOrderBeInteractedWith = false;
		
func _on_player_interaction_triggered(player: Player):
	if(canOrderBeInteractedWith):
		print("Player trying to deliver order");
		if(isOrderSatisfied(player.heldProduct)):
			orderCompletedSuccessfully(player);
		else:
			print("Order not satisfied")
		
func isOrderSatisfied(deliveredProduct : Product):
	print("Analyzing if product is sufficient");
	if(deliveredProduct == null):
		return false;
	
	if(deliveredProduct.type == requiredOrder.type):
		if(deliveredProduct.type == Product.productTypes.coffee):
			if(deliveredProduct.numberOfSugarAndCreamInCoffee == requiredOrder.numberOfSugarAndCreamInCoffee):
				return true;
		elif(deliveredProduct.type == Product.productTypes.espresso):
			if(deliveredProduct.espressoHasSteamedMilk == requiredOrder.espressoHasSteamedMilk):
				return true;
				
	return false;
	
func orderCompletedSuccessfully(player : Player):
	print("Order satisfied");
	isOrderOnGoing = false;
	var payoutAmount = determinePayoutAmount();
	payout_triggered.emit(payoutAmount);
	player.heldProduct = null;
	customer.orderCompleted();
	customer.assignedTable.showPayoutInfo(payoutAmount);
	self.queue_free();

func determinePayoutAmount():
	var percentComplete : float = orderTimer / orderTimeMax;
	var payoutAmount = 0;	
	if(percentComplete > 0.8):
		#full amount + 10%
		payoutAmount = basePayoutAmount + (basePayoutAmount * .1);
	elif(percentComplete > .5):
		#percentage of base amount flat
		payoutAmount = basePayoutAmount * percentComplete;
	else:
		#percentage of base amount minus 10% of received amount
		payoutAmount = (basePayoutAmount * percentComplete);
		payoutAmount = payoutAmount - (payoutAmount * .1);
	return snapped(payoutAmount, 0.01);
