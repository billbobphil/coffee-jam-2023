extends CharacterBody2D

class_name Customer

var assignedTable : Table;

#TODO: need logic to move to the table they were assigned to rather than just teleporting

func _ready():
	print("Customer Alive");
	
func assignTable(table:Table):
	assignedTable = table;
	position.x = assignedTable.position.x;
	position.y = assignedTable.position.y;

func placeOrder():
	#TODO: create an order
	pass
