extends Node2D

const TerrainGenerator = preload("res://TerrainGenerator.gd")

onready var TerrainL1 : TileMap = $TerrainL1
onready var line = $Line2D
onready var human = $YSort/Human
onready var camera = $Camera2D
onready var navigation_polygon = $NavigationPolygonInstance.navpoly

var generator

# Called when the node enters the scene tree for the first time.
func _ready():
	camera.position = human.position
	_proc_generation()

func _proc_generation():
	generator = TerrainGenerator.new(TerrainL1, navigation_polygon, $YSort)
	generator.temperature = generator.generate_map(300, 5)
	generator.moisture = generator.generate_map(300, 5)
	generator.altitude = generator.generate_map(150, 5)
	generator.generate_tilemap()
	generator.set_objects()

func create_2d_grid(w, h):
	var grid = []
	for x in range(w):
		var col = []
		col.resize(h)
		grid.append(col)
	return grid

func tilemap_to_data(tilemap : TileMap):
	var grid = create_2d_grid(60, 60)
	var tile_mapping : Dictionary = {}
	for tile_id in tilemap.tile_set.get_tiles_ids():
		tile_mapping[tilemap.tile_set.tile_get_name(tile_id)] = tile_id
	for pos in tilemap.get_used_cells():
		var cell = tilemap.get_cell(pos.x, pos.y)
		#print("x: ", pos.x," y: ", pos.y, " cell ", cell)
	pass

func _on_Human_path_changed(path):
	line.points = path
	
func _input(event):
	if event.is_action("navigation_target"):
		if event is InputEventMouseButton:
			human.walk_to(get_global_mouse_position())
			
