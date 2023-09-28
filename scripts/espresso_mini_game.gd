extends Node2D

@export var successSprite : Texture;
var numberOfSuccesses : int = 0;

@export var espressoPuckHalfSprite : Texture;
@export var espressoPuckDoneSprite : Texture;

signal espresso_mini_game_completed;

func _on_area_2d_body_entered(body):
	if(body.name == "EspressoPresserCollider"):
		print("DID IT!")
		$ThudSoundEffect.play();
		numberOfSuccesses += 1;
		updateSuccessSprites();
		if(numberOfSuccesses == 3):
			espresso_mini_game_completed.emit();
		
func updateSuccessSprites():
	print("Updating");
	if(numberOfSuccesses == 1):
		$SuccessIndicator_One.texture = successSprite;
		get_node("EspressoPuck/Sprite2D").texture = espressoPuckHalfSprite;
	elif(numberOfSuccesses == 2):
		$SuccessIndicator_Two.texture = successSprite;
		get_node("EspressoPuck/Sprite2D").texture = espressoPuckDoneSprite;
	elif(numberOfSuccesses == 3):
		$SuccessIndicator_Three.texture = successSprite;
