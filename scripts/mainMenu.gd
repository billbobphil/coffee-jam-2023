extends CanvasLayer

func _ready():
	get_tree().paused = false;
	
func _process(_delta):
	if(Input.is_action_just_pressed("dash")):
		get_tree().change_scene_to_file("res://scenes/rootScene.tscn");	

func _on_play_button_pressed():
	$ButtonClickSoundEffect.play();
	get_tree().change_scene_to_file("res://scenes/rootScene.tscn");

func _on_play_button_mouse_entered():
	$ButtonHoverSoundEffect.play();
	
