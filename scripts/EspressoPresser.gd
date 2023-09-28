extends Node2D

class_name EspressoPresser

@export var speed : float = 100;
@export var leftBound : int = 0;
@export var rightBound : int = 0;
var isMovingRight : bool = true;
var isDepressed : bool = false;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if(Input.is_action_just_pressed("dash") && !isDepressed):
		isDepressed = true;
		$WhiffSoundEffect.play();
		position.y = 220 - 16;
		await get_tree().create_timer(.2).timeout;
		position.y = 90;
		await get_tree().create_timer(.5).timeout;
		isDepressed = false;
	
	if(isMovingRight):
		position.x += delta * speed;
		if(position.x >= rightBound):
			isMovingRight = false;
	else:
		position.x -= delta * speed;
		if(position.x <= leftBound):
			isMovingRight = true;
