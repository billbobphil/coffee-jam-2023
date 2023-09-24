extends CharacterBody2D

class_name Customer

var assignedTable : Table;
var shouldMoveToTable : bool = false;
var shouldLeave : bool = false;
var destination : Vector2;
var spawnPosition : Vector2;
@export var speed : float = 100;
var type : Customer.Types;
var customerSprite;

enum Types {
	SPIDER,
	PUMPKIN,
	GHOST
}

signal place_order;
signal customer_in_despawn;

func _ready():
	print("Customer Alive");
	customerSprite = get_node("CustomerSprite");
	var orderManager = get_node("../../OrderManager");
	if(orderManager):
		self.place_order.connect(orderManager._on_place_order);
	
func _process(delta):
	if(shouldMoveToTable):
		self.position = self.position.move_toward(destination, delta * speed);
		if(self.position == destination):
			shouldMoveToTable = false;
			place_order.emit(self);
			toggleSpriteToLeavingSprite();
	
	if(shouldLeave):
		self.position = self.position.move_toward(spawnPosition, delta * speed);
		if(self.position == spawnPosition):
			#TODO: logic to despawn
			print("Customer should de-spawn now");
			shouldLeave = false;
			customer_in_despawn.emit(self);
	pass
	
func assignTable(table:Table):
	assignedTable = table;
	destination = assignedTable.position;
	shouldMoveToTable = true;

func orderCompleted():
	print("Customer should leave now")
	shouldLeave = true;
	
func assignType(typeToAssign : Types):
	type = typeToAssign;
	
	if(type == Types.SPIDER):
		customerSprite.play("spider_arriving");
	elif(type == Types.GHOST):
		customerSprite.play("ghost_arriving");
	elif(type == Types.PUMPKIN):
		customerSprite.play("pumpkin_arriving");
	
func toggleSpriteToLeavingSprite():
	if(type == Types.SPIDER):
		customerSprite.play("spider_leaving");
	elif(type == Types.GHOST):
		customerSprite.play("ghost_leaving");
	elif(type == Types.PUMPKIN):
		customerSprite.play("pumpkin_leaving")
