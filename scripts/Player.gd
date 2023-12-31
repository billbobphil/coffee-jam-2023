extends CharacterBody2D

class_name Player;

const SPEED = 175;
const DASH_SPEED_MULTIPLIER = 15;
const DASH_COOLDOWN = 1;
signal interaction_triggered
var isDashAvailable = true;
var dashTimer = 0;
var heldProduct : Product;

var espressoSprite = preload("res://art/espresso-black-32x32.png");
var coffeeSpriteZero = preload("res://art/coffee-zero-32x32.png");
var coffeeSpriteOne = preload("res://art/coffee-one-32x32.png");
var coffeeSpriteTwo = preload("res://art/coffee-two-32x32.png");
var latteSprite = preload("res://art/latte-32x32.png");
@onready var animatedSprite = $AnimatedSprite2D;
@onready var leftProductPosition = get_node("ProductPositions/Left");
@onready var rightProductPosition = get_node("ProductPositions/Right");
@onready var topProductPosition = get_node("ProductPositions/Top");
@onready var bottomProductPosition = get_node("ProductPositions/Bottom");
@onready var productSprite : Sprite2D = $ProductSprite;
@onready var moveSoundEffect = $MoveSoundEffect;
@export var moveSoundEffects : Array[AudioStream];
var moveSoundEffectsIndex = 0;
var areInputsEnabled = true;

func _ready():
	#TODO: add logic to _process to understand which sprite to use
	animatedSprite.play("walk_down");

func _physics_process(delta):
	if(!areInputsEnabled): return;
	
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var moveSpeed = SPEED;
	if(Input.is_action_just_pressed("dash") && isDashAvailable):
		moveSpeed *= DASH_SPEED_MULTIPLIER;
		isDashAvailable = false
		dashTimer = 0;
	velocity = direction * moveSpeed
	if(velocity.x != 0 || velocity.y != 0) :
		if(!moveSoundEffect.playing):
			moveSoundEffect.stream = moveSoundEffects[moveSoundEffectsIndex];
			moveSoundEffect.play();
			moveSoundEffectsIndex += 1;
			if(moveSoundEffectsIndex >= moveSoundEffects.size()):
				moveSoundEffectsIndex = 0;
	move_and_slide()
	
func _process(delta):
	if(!areInputsEnabled): return;
	
	dashTimer += delta;
	if(Input.is_action_just_pressed("interact")):
		print("Player pressed interact")
		interaction_triggered.emit(self)
	if(dashTimer > DASH_COOLDOWN && !isDashAvailable):
		isDashAvailable = true;
	
	if(Input.is_action_pressed("move_down")):
		animatedSprite.play("walk_down");
		productSprite.position = bottomProductPosition.position;
	elif(Input.is_action_pressed("move_up")):
		animatedSprite.play("walk_up");
		productSprite.position = topProductPosition.position;
	elif(Input.is_action_pressed("move_left")):
		animatedSprite.play("walk_left")
		productSprite.position = leftProductPosition.position;
	elif(Input.is_action_pressed("move_right")):
		animatedSprite.play("walk_right");
		productSprite.position = rightProductPosition.position;
#	else:
#		if(animatedSprite.animation != "walk_down"):
#			animatedSprite.play("walk_down");
#			productSprite.position = bottomProductPosition.position;
		

func canAcceptProduct(product : Product):
	if(heldProduct == null):
		if(product.type == Product.productTypes.coffee || product.type == Product.productTypes.espresso):
			return true;
	elif(heldProduct.type == Product.productTypes.coffee):
		if(product.type == Product.productTypes.sugarAndCream):
			return true;
	elif(heldProduct.type == Product.productTypes.espresso):
		if(product.type == Product.productTypes.steamedMilk):
			return true;
			
	print("Player could not accept product");		
	return false;

func giveProduct(product : Product):
	if(heldProduct == null):
		heldProduct = product;
		print("Player was given product to hold");
	elif(heldProduct.type == Product.productTypes.coffee):
		if(product.type == Product.productTypes.sugarAndCream):
			heldProduct.numberOfSugarAndCreamInCoffee += 1;
			print("Coffee was combined with sugar and cream");
	elif(heldProduct.type == Product.productTypes.espresso):
		if(product.type == Product.productTypes.steamedMilk):
			heldProduct.espressoHasSteamedMilk = true;
			print("Espresso was combined with steamed milk");
	setProductSprite();
			
func takeProduct():
	heldProduct = null;
	setProductSprite();
			
func setProductSprite():
	if(heldProduct == null):
		$ProductSprite.visible = false;
		return;
	elif(heldProduct.type == Product.productTypes.espresso):
		if(heldProduct.espressoHasSteamedMilk):
			$ProductSprite.texture = latteSprite;
		else:
			$ProductSprite.texture = espressoSprite;
	elif(heldProduct.type == Product.productTypes.coffee):
		if(heldProduct.numberOfSugarAndCreamInCoffee == 0):
			$ProductSprite.texture = coffeeSpriteZero;
		elif(heldProduct.numberOfSugarAndCreamInCoffee == 1):
			$ProductSprite.texture = coffeeSpriteOne;
		elif(heldProduct.numberOfSugarAndCreamInCoffee == 2):
			$ProductSprite.texture = coffeeSpriteTwo;
		pass;

	$ProductSprite.visible = true;
