extends StaticBody2D

var keyPromptSprite;
var stationCanBeInteractedWith = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	keyPromptSprite = get_node("Key Prompt Sprite");


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


func _on_player_interaction_triggered():
	if(stationCanBeInteractedWith):
		print("interacting with coffee station")
