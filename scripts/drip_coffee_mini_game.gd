extends Node2D

var numberOfBallsCaught : int = 0;
@export var numberOfBallsRequired : int = 0;

var numberOfBallsActive : int = 0;
@export var maxNumberOfBallsAllowed : int = 0;
@export var spawnPoints : Array[Node2D];
@export var ballScene = preload("res://scenes/pachinko_ball.tscn");

@export var catcherOneSprite : Texture;
@export var catcherTwoSprite : Texture;

signal coffee_mini_game_completed;

func _ready():
	numberOfBallsActive = maxNumberOfBallsAllowed;

func _process(_delta):
	if(numberOfBallsActive < maxNumberOfBallsAllowed):
		spawnBall();
		
func _on_area_2d_body_entered(body):
	if(body is PachinkoBall):
		$CatchSoundEffect.play();
		numberOfBallsCaught += 1;
		numberOfBallsActive -= 1;
		body.queue_free();
		if(numberOfBallsCaught == 2):
			get_node("Catcher/Sprite2D").texture = catcherOneSprite;
		elif(numberOfBallsCaught == 3):
			get_node("Catcher/Sprite2D").texture = catcherTwoSprite;
		elif(numberOfBallsCaught == numberOfBallsRequired):
			coffee_mini_game_completed.emit();
			print("WIN");

func _on_bounds_body_entered(body):
	if(body is PachinkoBall):
		numberOfBallsActive -= 1;
		body.queue_free();
		
func spawnBall():
	numberOfBallsActive += 1;
	var positionToSpawn = spawnPoints.pick_random().position;
	var createdBall = ballScene.instantiate();
	add_child(createdBall);
	createdBall.position = positionToSpawn;
