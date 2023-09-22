extends CharacterBody2D

class_name Player;

const SPEED = 100;
const DASH_SPEED_MULTIPLIER = 25;
const DASH_COOLDOWN = 1;
signal interaction_triggered
var isDashAvailable = true;
var dashTimer = 0;
var heldProduct : Product;

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var moveSpeed = SPEED;
	if(Input.is_action_just_pressed("dash") && isDashAvailable):
		moveSpeed *= DASH_SPEED_MULTIPLIER;
		isDashAvailable = false
		dashTimer = 0;
	velocity = direction * moveSpeed
	move_and_slide()
	
func _process(delta):
	dashTimer += delta;
	if(Input.is_action_just_pressed("interact")):
		print("Player pressed interact")
		interaction_triggered.emit(self)
	if(dashTimer > DASH_COOLDOWN && !isDashAvailable):
		isDashAvailable = true;

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
	#TODO; should probably have different classes that are extensions of products?
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
