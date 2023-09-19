extends Node2D

var customerScene = preload("res://scenes/customer.tscn");
var customers : Array[Customer] = [];
@export var tables: Array[Table]
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Customer spawn point created");
	print(tables);
	await get_tree().create_timer(2.0).timeout
	spawn_customer();
	
func spawn_customer():
	print("spawning customer");
	var customer : Customer = customerScene.instantiate();
	var spawnPoint = get_node("SpawnPoint");
	add_child(customer);
	customer.position.x = spawnPoint.position.x;
	customer.position.y = spawnPoint.position.y;
	customers.push_back(customer);
	
	#TODO: remove the timeouts and replace with an animation to move to the table
	await get_tree().create_timer(2.0).timeout
	
	var areAnyTablesAvailable : bool = false;
	var availableTables: Array[Table] = [];
	
	for table in tables:
		if(!table.isOccupied):
			availableTables.push_back(table)
			areAnyTablesAvailable = true;
			
	if(!areAnyTablesAvailable): 
		return;
		
	var tableToAssign: Table;
	tableToAssign = availableTables.pick_random();
	customer.assignTable(tableToAssign);
	
	
