extends Node2D

class_name Order

@export var orderTimeMax : float = 3;
var orderTimer : float = 0;
var isOrderTimerStarted : bool = false;
@export var yFloatMax : float = 4;
@export var yFloatMin : float = -4;
@export var floatIncrement : float = 10;
var shouldFloat : bool = false;
var initialPositionY : float;
var direction : int = 1;
var isOrderOnGoing : bool = false;
var orderType : OrderManager.orderTypes;
var customer : Customer;

signal order_expired;
signal order_fulfilled;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func startOrderTimer():
	print("Order timer started");
	isOrderTimerStarted = true;
	isOrderOnGoing = true;
	shouldFloat = true;
	initialPositionY = position.y;
	print("Order type: " + str(orderType));

# Called every frame. 'delta' is the elapsed time since the previous frame.
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
