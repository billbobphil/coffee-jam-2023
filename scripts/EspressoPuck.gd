extends Node2D

class_name EspressoPuck

@export var speed : float = 100;
@export var leftBound : int = 0;
@export var rightBound : int = 0;
var isMovingRight : bool = true;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(isMovingRight):
		position.x += delta * speed;
		if(position.x >= rightBound):
			isMovingRight = false;
	else:
		position.x -= delta * speed;
		if(position.x <= leftBound):
			isMovingRight = true;
