extends RigidBody2D

class_name PachinkoBall

@onready var bonkSoundEffect = $BonkSoundEffect;

func _on_body_entered(body):
	if(body is PachinkoNub && !bonkSoundEffect.playing):
		bonkSoundEffect.play();
