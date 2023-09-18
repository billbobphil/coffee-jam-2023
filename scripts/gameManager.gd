extends Node2D

enum cam_positions {
	KITCHEN,
	STOREFRONT
}

var currentCamPosition = cam_positions.STOREFRONT;
var kitchenCamera;
var storefrontCamera;

func _ready():
	kitchenCamera = $KitchenCamera;
	storefrontCamera = $StorefrontCamera;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_just_pressed("change_camera")):
		change_camera("button");
		
func _on_change_camera(body, triggerName):
	if(body.name == "Player"):
		change_camera(triggerName);
		
func change_camera(triggerName):
	print("Change camera with trigger: " + triggerName)
	if(triggerName == "button"):
		match currentCamPosition:
			cam_positions.KITCHEN:
				storefrontCamera.make_current();
				currentCamPosition = cam_positions.STOREFRONT;
			cam_positions.STOREFRONT:
				kitchenCamera.make_current();
				currentCamPosition = cam_positions.KITCHEN;
	elif (triggerName == "kitchen" && currentCamPosition != cam_positions.KITCHEN):
		kitchenCamera.make_current();
		currentCamPosition = cam_positions.KITCHEN;
	elif (triggerName == "storefront" && currentCamPosition != cam_positions.STOREFRONT):
		storefrontCamera.make_current();
		currentCamPosition = cam_positions.STOREFRONT;
