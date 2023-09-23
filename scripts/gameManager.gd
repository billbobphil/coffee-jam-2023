extends Node2D

enum cam_positions {
	KITCHEN,
	STOREFRONT
}

var currentCamPosition = cam_positions.STOREFRONT;
var kitchenCamera;
var storefrontCamera;
var totalRevenue : float = 0;

func _ready():
	kitchenCamera = $KitchenCamera;
	storefrontCamera = $StorefrontCamera;
	get_node("OrderManager").payout_triggered.connect(_on_payout_triggered);

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
		
func _on_payout_triggered(amount : float):
	print("Payout triggered");
	totalRevenue += amount;
	get_node("CanvasLayer/RevenueText").text = "$" + str(totalRevenue);
