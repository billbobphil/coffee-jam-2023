extends Node2D

class_name Order

@export var orderTimeMax : float = 20;
var orderTimer : float = 0;
var isOrderTimerStarted : bool = false;
@export var yFloatMax : float = 4;
@export var yFloatMin : float = -4;
@export var floatIncrement : float = 10;
var shouldFloat : bool = false;
var initialPositionY : float;
var direction : int = 1;
var isOrderOnGoing : bool = false;
var customer : Customer;
var canOrderBeInteractedWith : bool = false;
var requiredOrder : Product;


signal order_expired;
signal order_fulfilled;

func _ready():
	var player = get_tree().get_first_node_in_group("Player")
	player.interaction_triggered.connect(_on_player_interaction_triggered);
	
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
	pass
	
func orderTimerRoutine(delta):
	if(isOrderTimerStarted && isOrderOnGoing):
		orderTimer += delta;
		if(orderTimer >= orderTimeMax):
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
	player.heldProduct = null;
	customer.orderCompleted();
	self.queue_free();
