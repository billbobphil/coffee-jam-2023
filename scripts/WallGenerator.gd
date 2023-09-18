extends Node2D

const NUMBER_OF_WALLS_BETWEEN = 14;
var wallScene = preload("res://scenes/wall.tscn");
const STARTING_TOP_POSITION_X = 112; 
const GAME_WIDTH_UNITS = 20;
const GAME_HEIGHT_UNITS = 22;

# Called when the node enters the scene tree for the first time.
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
	for i in GAME_WIDTH_UNITS + 1:
		var createdWall = wallScene.instantiate();
		createdWall.position.x = 0 + (i * 32);
		createdWall.position.y = 0;
		add_child(createdWall);
		
		var createdFarWall = wallScene.instantiate();
		createdFarWall.position.x = 0 + (i * 32);
		createdFarWall.position.y = 720;
		add_child(createdFarWall);
		
func create_outer_vertical_walls():
	for i in GAME_HEIGHT_UNITS + 1:
		var createdWall = wallScene.instantiate();
		createdWall.position.x = 0;
		createdWall.position.y = 0 + (i * 32);
		add_child(createdWall);
		
		var createdFarWall = wallScene.instantiate()
		createdFarWall.position.x = 640;
		createdFarWall.position.y = 0 + (i * 32);
		add_child(createdFarWall);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
		
	
