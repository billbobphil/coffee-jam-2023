extends StaticBody2D

var coffeeStationSprite = preload("res://art/coffee-station-64x64.png");
var espressoStationSprite = preload("res://art/espresso-station-64x64.png");
var sugarAndCreamStationSprite = preload("res://art/sugarAndCreamStation-64x64.png");
var steamerStation = preload("res://art/steamer-station-64x64.png");

var keyPromptSprite;
var stationCanBeInteractedWith = false;
@export var stationName: String = "";

@export var productType : Product.productTypes = Product.productTypes.coffee;

# Called when the node enters the scene tree for the first time.
func _ready():
	keyPromptSprite = get_node("Key Prompt Sprite");
	var player = get_tree().get_first_node_in_group("Player")
	player.interaction_triggered.connect(_on_player_interaction_triggered)
	if(productType == Product.productTypes.coffee):
		get_node("Station Sprite").texture = coffeeStationSprite;
	if(productType == Product.productTypes.espresso):
		get_node("Station Sprite").texture = espressoStationSprite;
	if(productType == Product.productTypes.steamedMilk):
		get_node("Station Sprite").texture = steamerStation;
	if(productType == Product.productTypes.sugarAndCream):
		get_node("Station Sprite").texture = sugarAndCreamStationSprite;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_2d_body_entered(body):
	if(body.name == "Player"):
		print('Player has entered station area')
		keyPromptSprite.visible = true;
		stationCanBeInteractedWith = true;

func _on_area_2d_body_exited(body):
	if(body.name == "Player"):
		print('Player has left station area')
		keyPromptSprite.visible = false;
		stationCanBeInteractedWith = false;


func _on_player_interaction_triggered(player: Player):
	if(stationCanBeInteractedWith):
		print("interacting with station: " + stationName)
		var product = Product.new();
		product.type = productType;
		if(player.canAcceptProduct(product)):
			player.giveProduct(product);
			$InteractSoundEffect.play();
		
