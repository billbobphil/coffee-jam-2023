extends CharacterBody2D

class_name Customer

var assignedTable : Table;
var shouldMoveToTable : bool = false;
var shouldLeave : bool = false;
var destination : Vector2;
@export var speed : float = 100;
signal place_order;

#TODO: need logic to move to the table they were assigned to rather than just teleporting

func _ready():
	print("Customer Alive");
	var orderManager = get_node("../../OrderManager");
	if(orderManager):
		self.place_order.connect(orderManager._on_place_order);
	
func _process(delta):
	if(shouldMoveToTable):
		self.position = self.position.move_toward(destination, delta * speed);
		if(self.position == destination):
			shouldMoveToTable = false;
			place_order.emit(self);
	pass
	
func assignTable(table:Table):
	assignedTable = table;
	destination = assignedTable.position;
	shouldMoveToTable = true;

func hello():
	print("HI!");
