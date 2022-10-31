extends Node2D

onready var TerrainL1 : TileMap = $TerrainL1
onready var line = $Line2D
onready var human = $YSort/Human
onready var camera = $Camera2D
onready var navigation_polygon = $NavigationPolygonInstance.navpoly
onready var object_container = $YSort

var generator

# Called when the node enters the scene tree for the first time.
func _ready():
	human.game = self
	camera.position = human.position
	_proc_generation()

func _proc_generation():
	generator = TerrainGenerator.new(TerrainL1, navigation_polygon, self)
	generator.temperature = generator.generate_map(300, 5)
	generator.moisture = generator.generate_map(300, 5)
	generator.altitude = generator.generate_map(150, 5)
	generator.generate_tilemap()
	generator.set_objects()

func _on_Human_path_changed(path):
	line.points = path
	
func _input(event):
	if event.is_action("navigation_target"):
		if event is InputEventMouseButton:
			human.walk_to(get_global_mouse_position())
			
func _on_gather_selection(object):
	print("on_gather_selection: ", object)

func spawn_object(object):
	if object.has_method("added_to_game"):
		object.added_to_game(self)
	object_container.add_child(object)


func _on_UI_create_plan(goal):
	print(goal)
	human.create_ai_plan(goal)
