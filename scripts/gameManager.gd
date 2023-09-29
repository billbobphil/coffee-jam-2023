extends Node2D

enum cam_positions {
	KITCHEN,
	STOREFRONT
}

var currentCamPosition = cam_positions.STOREFRONT;
var kitchenCamera;
var storefrontCamera;
var totalRevenue : float = 0;
@export var dayLength: float = 300;
var dayTimer = 0;
var timeRemainingBar;
var isShopOpen : bool = true;
var levelEndScreen;
var totalCustomersServed = 0;

@export var espressoMinigame : PackedScene;
@export var latteMinigame : PackedScene;
@export var sugarMinigame : PackedScene;
@export var coffeeMinigame : PackedScene;

var activeMiniGameReference;

func _ready():
	get_tree().paused = false;
	kitchenCamera = $KitchenCamera;
	storefrontCamera = $StorefrontCamera;
	levelEndScreen = $LevelEndScreen;
	timeRemainingBar = get_node("HUD/TimeRemainingBar");
	dayTimer = dayLength;
	get_node("OrderManager").payout_triggered.connect(_on_payout_triggered);

func _process(delta):
	if(dayTimer > 0 && isShopOpen):
		dayTimer -= delta;
		timeRemainingBar.value = (dayTimer / dayLength) * 100;
	elif(dayTimer <= 0 && isShopOpen):
		print("Day ended");
		isShopOpen = false;
		levelEndScreen.showDialog(totalCustomersServed, totalRevenue);
		get_tree().paused = true;
		
	if(Input.is_action_just_pressed("change_camera") && !activeMiniGameReference):
		change_camera("button");
		
func _on_change_camera(body, triggerName):
	if(body.name == "Player"):
		change_camera(triggerName);
		
func change_camera(triggerName):
	print("Change camera with trigger: " + triggerName)
	if(triggerName == "button"):
		match currentCamPosition:
			cam_positions.KITCHEN:
				storefrontCamera.make_current();
				currentCamPosition = cam_positions.STOREFRONT;
			cam_positions.STOREFRONT:
				kitchenCamera.make_current();
				currentCamPosition = cam_positions.KITCHEN;
	elif (triggerName == "kitchen" && currentCamPosition != cam_positions.KITCHEN):
		kitchenCamera.make_current();
		currentCamPosition = cam_positions.KITCHEN;
	elif (triggerName == "storefront" && currentCamPosition != cam_positions.STOREFRONT):
		storefrontCamera.make_current();
		currentCamPosition = cam_positions.STOREFRONT;
		
func _on_payout_triggered(amount : float):
	print("Payout triggered");
	if(totalRevenue + amount <= 0):
		totalRevenue = 0;
	else:
		totalRevenue += amount;
	totalCustomersServed += 1;
	get_node("HUD/RevenueText").text = "$" + str(totalRevenue);


func _on_minigame_started(stationName):
	print("STATION MINIGAME STARTED: " + stationName);
	$Player.areInputsEnabled = false;
	if(stationName == "Espresso"):
		activeMiniGameReference = espressoMinigame.instantiate();
		add_child(activeMiniGameReference);
		activeMiniGameReference.espresso_mini_game_completed.connect(_on_minigame_completed);
	elif(stationName == "Milk Steamer"):
		activeMiniGameReference = latteMinigame.instantiate();
		add_child(activeMiniGameReference);
		activeMiniGameReference.latte_mini_game_completed.connect(_on_minigame_completed);
	elif(stationName == "Drip Coffee"):
		activeMiniGameReference = coffeeMinigame.instantiate();
		add_child(activeMiniGameReference);
		activeMiniGameReference.coffee_mini_game_completed.connect(_on_minigame_completed);
	elif(stationName == "Milk and Sugar"):
		activeMiniGameReference = sugarMinigame.instantiate();
		add_child(activeMiniGameReference);
		activeMiniGameReference.milk_and_sugar_mini_game_completed.connect(_on_minigame_completed);
		
func _on_minigame_completed():
	$Player.areInputsEnabled = true;
	activeMiniGameReference.queue_free();
