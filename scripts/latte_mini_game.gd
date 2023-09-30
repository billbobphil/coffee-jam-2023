extends Node2D

signal latte_mini_game_completed;

@export var speed : float = 0;
@export var successTexture = preload("res://art/success_indicator_full.png");
@export var windows : Array[Vector2];
@export var latteOneTexture : Texture;
@export var latteTwoTexture : Texture
@export var latteThreeTexture : Texture

@onready var progressBar = $ForegroundBar;
@onready var minBar = $MinBar;
@onready var maxBar = $MaxBar;
var hasStartedPressing : bool = false;
var canPress : bool = true;
var currentWindow : Vector2;
var successes : int = 0;

func _ready():
	resetGame();
	
func resetGame():
	var currentPick = windows.pick_random();
	while(currentPick == currentWindow):
		currentPick = windows.pick_random();	
	
	currentWindow = currentPick;
	minBar.value = currentWindow.x;
	maxBar.value = currentWindow.y;
	progressBar.value = 0;
	canPress = true;

func _process(delta):
	if(Input.is_action_just_released("dash")):
		canPress = false;
		processButtonRelease()
	
	if(Input.is_action_pressed("dash") && canPress):
		progressBar.value += speed * delta;

func processButtonRelease():
	print("Current value: " + str(progressBar.value));
	if(progressBar.value > currentWindow.x && progressBar.value < currentWindow.y):
		successes += 1;
		$SuccessSoundEffect.play();
	else:
		$FailSoundEffect.play();
	
	if(successes == 1):
		$Indicator_One.texture = successTexture;
		$LatteArt.texture = latteOneTexture;
	elif(successes == 2):
		$Indicator_Two.texture = successTexture;
		$LatteArt.texture = latteTwoTexture;
	elif(successes == 3):
		$Indicator_Three.texture = successTexture;
		$LatteArt.texture = latteThreeTexture;
	elif(successes == 4):
		$Indicator_Four.texture = successTexture;
		latte_mini_game_completed.emit();
		
	resetGame();
