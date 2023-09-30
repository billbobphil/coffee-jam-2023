extends Node2D


signal milk_and_sugar_mini_game_completed;

var correctInputs : int = 0;
@export var upArrow : Arrow;
@export var downArrow : Arrow;
@export var leftArrow : Arrow;
@export var rightArrow : Arrow;
@export var requiredInputsToWin : int = 0;

@export var coffeeSwirlOne : Texture;
@export var coffeeSwirlTwo : Texture;
@export var coffeeSwirlThree : Texture;

@export var inactiveSprite : Texture;
@export var activeSprite : Texture;

var arrowsOnIndex : Array[Arrow];
var arrows = [0,1,2,3]
var currentArrow = -1; #0,1,2,3 (clockwise)
var needToSelectArrow = true;

func _ready():
	arrowsOnIndex.push_back(upArrow);
	arrowsOnIndex.push_back(rightArrow);
	arrowsOnIndex.push_back(downArrow);
	arrowsOnIndex.push_back(leftArrow);


func _process(delta):	
	processInputs();
	
	if(needToSelectArrow):
		needToSelectArrow = false;
		var selectedArrow = arrows.pick_random();
		while(selectedArrow == currentArrow):
			selectedArrow = arrows.pick_random();
		currentArrow = selectedArrow;
		arrowsOnIndex[currentArrow].setSprite(activeSprite, true);
		
func processInputs():	
	#you can tell this is the end of the jam, code got the big ick
	if(currentArrow == 0):
		if(Input.is_action_just_pressed("move_up")):
			arrowsOnIndex[0].setSprite(inactiveSprite, false);
			needToSelectArrow = true;
			correctInputs += 1;
			checkForWin();
			$SuccessSoundEffect.play();
	elif(currentArrow == 1):
		if(Input.is_action_just_pressed("move_right")):
			arrowsOnIndex[1].setSprite(inactiveSprite, false);
			needToSelectArrow = true;
			correctInputs += 1;
			checkForWin();
			$SuccessSoundEffect.play();
	elif(currentArrow == 2):
		if(Input.is_action_just_pressed("move_down")):
			arrowsOnIndex[2].setSprite(inactiveSprite, false);
			needToSelectArrow = true;
			correctInputs += 1;
			checkForWin();
			$SuccessSoundEffect.play();
	elif(currentArrow == 3):
		if(Input.is_action_just_pressed("move_left")):
			arrowsOnIndex[3].setSprite(inactiveSprite, false);
			needToSelectArrow = true;
			correctInputs += 1;
			checkForWin();
			$SuccessSoundEffect.play();
		
func checkForWin():
	if(correctInputs >= requiredInputsToWin):
		print("WIN");
		milk_and_sugar_mini_game_completed.emit();
	
	if(correctInputs == 2):
		$CoffeeSprite.texture = coffeeSwirlOne;
	elif(correctInputs == 4):
		$CoffeeSprite.texture = coffeeSwirlTwo;
	elif(correctInputs == 9):
		$CoffeeSprite.texture = coffeeSwirlThree;
