extends PointLight2D

var randomInterval;
var timer = 0;
var isFlickering : bool = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	randomInterval = randi() % 15;
	randomInterval += 5;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer += delta;
	
	if(timer >= randomInterval && !isFlickering):
		flicker();

func flicker():
	isFlickering = true;
	visible = false;
	await get_tree().create_timer(.1).timeout;
	visible = true;
	await get_tree().create_timer(.2).timeout;
	visible = false;
	await get_tree().create_timer(.2).timeout;
	visible = true;
	await get_tree().create_timer(.1).timeout;
	visible = false;
	await get_tree().create_timer(.3).timeout;
	visible = true;
	timer = 0;
	isFlickering = false;
