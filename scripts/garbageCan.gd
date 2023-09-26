extends Node2D

@onready var interactSprite = $InteractSprite;
var canInteract : bool = false;
var playerRef : Player;

func _process(delta):
	if(Input.is_action_just_pressed("interact") && canInteract):
		playerRef.takeProduct();

func _on_area_2d_body_entered(body):
	if(body.name == "Player"):
		interactSprite.visible = true;
		canInteract = true;
		playerRef = body;

func _on_area_2d_body_exited(body):
	if(body.name == "Player"):
		interactSprite.visible = false;
		canInteract = false;
