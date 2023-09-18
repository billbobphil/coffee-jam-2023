extends CharacterBody2D

const SPEED = 100;
const DASH_SPEED_MULTIPLIER = 25;
const DASH_COOLDOWN = 1;
signal interaction_triggered
var isDashAvailable = true;
var dashTimer = 0;

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
		interaction_triggered.emit()
	if(dashTimer > DASH_COOLDOWN && !isDashAvailable):
		isDashAvailable = true;
