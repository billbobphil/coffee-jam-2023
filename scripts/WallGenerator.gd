extends Node2D

const NUMBER_OF_WALLS_BETWEEN = 14;
var wallScene = preload("res://scenes/wall.tscn");
const STARTING_TOP_POSITION_X = 112; 
const GAME_WIDTH_UNITS = 20;
const GAME_HEIGHT_UNITS = 22;

var top = preload("res://art/walls/top.png");
var topLeft = preload("res://art/walls/top-left.png");
var topRight = preload("res://art/walls/top-right.png");
var right = preload("res://art/walls/right.png");
var left = preload("res://art/walls/left.png");
var bottom = preload("res://art/walls/bottom.png");
var bottomLeft = preload("res://art/walls/bottom-left.png");
var bottomRight = preload("res://art/walls/bottom-right.png");

func _ready():
	generate_walls();
	
func generate_walls():
	create_walls_between();
	create_outer_vertical_walls();
	create_outer_horizontal_walls();
		
func create_walls_between():
	for i in NUMBER_OF_WALLS_BETWEEN:
		var createdWall = wallScene.instantiate();
		createdWall.position.x = STARTING_TOP_POSITION_X + (i * 32);
		createdWall.position.y = 360;
		add_child(createdWall);
		
func create_outer_horizontal_walls():
	for i in GAME_WIDTH_UNITS:
		var createdWall = wallScene.instantiate();
		createdWall.position.x = 14 + (i * 32);
		createdWall.position.y = 206;
		createdWall.get_node("Sprite2D").texture = top;
		if(i == 0):
			createdWall.get_node("Sprite2D").texture = topLeft;
		if(i == GAME_WIDTH_UNITS - 1):
			createdWall.get_node("Sprite2D").texture = topRight;
		add_child(createdWall);
		
		var createdFarWall = wallScene.instantiate();
		createdFarWall.position.x = 14 + (i * 32);
		createdFarWall.position.y = 706;
		createdFarWall.get_node("Sprite2D").texture = bottom;
		if(i == 0):
			createdFarWall.get_node("Sprite2D").texture = bottomLeft;
		if(i == GAME_WIDTH_UNITS - 1):
			createdFarWall.get_node("Sprite2D").texture = bottomRight;
		add_child(createdFarWall);
		
func create_outer_vertical_walls():
	for i in GAME_HEIGHT_UNITS + 1:
		var createdWall = wallScene.instantiate();
		createdWall.position.x = 14;
		createdWall.position.y = 0 + (i * 32);
		createdWall.get_node("Sprite2D").texture = left;
		add_child(createdWall);

		var createdFarWall = wallScene.instantiate()
		createdFarWall.position.x = 622;
		createdFarWall.position.y = 0 + (i * 32);
		createdFarWall.get_node("Sprite2D").texture = right;
		add_child(createdFarWall);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
		
	
