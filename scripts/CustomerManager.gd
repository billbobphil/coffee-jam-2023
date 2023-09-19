extends Node2D

var customerScene = preload("res://scenes/customer.tscn");
var customers = [];

# Called when the node enters the scene tree for the first time.
func _ready():
	print("customer spawn point")
	var customer = customerScene.instantiate();
	add_child(customer);
	customers.push_back(customer);
