extends CharacterBody2D

const SPEED = 100;
signal interaction_triggered

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * SPEED
	move_and_slide()
	
func _process(delta):
	if(Input.is_action_just_pressed("interact")):
		print("interaction triggered")
		interaction_triggered.emit()
	
