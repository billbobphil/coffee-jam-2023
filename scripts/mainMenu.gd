extends CanvasLayer

func _ready():
	get_tree().paused = false;

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://scenes/rootScene.tscn");
