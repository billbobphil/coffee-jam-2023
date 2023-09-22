extends Node

class_name Product

enum productTypes {
	espresso,
	coffee,
	sugarAndCream,
	steamedMilk
}

var type : Product.productTypes;
var espressoHasSteamedMilk : bool = false;
var numberOfSugarAndCreamInCoffee : int = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
