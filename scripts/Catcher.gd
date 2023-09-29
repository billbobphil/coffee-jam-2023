extends Node2D

@export var speed : float = 0;
@export var leftBound : int = 0;
@export var rightBound : int = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_pressed("move_left") && position.x > leftBound):
		position.x -= delta * speed;
	elif(Input.is_action_pressed("move_right") && position.x < rightBound):
		position.x += delta * speed;
