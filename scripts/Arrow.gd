extends Node2D

class_name Arrow;
	
func setSprite(newTexture : Texture, isInteract : bool):
	var sprite = get_node("Sprite2D");
	sprite.texture = newTexture;
	if(isInteract):
		scale.x = 1.5;
		scale.y = 1.5;
	else:
		scale.x = 1;
		scale.y = 1;
	
