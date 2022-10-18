extends Node2D

const TerrainGenerator = preload("res://TerrainGenerator.gd")

onready var tilemap = $TileMap

var generator

func _ready():
	generator = TerrainGenerator.new(tilemap, $YSort)
	generator.temperature = generator.generate_map(300, 5)
	generator.moisture = generator.generate_map(300, 5)
	generator.altitude = generator.generate_map(150, 5)
	generator.generate_tilemap()

func _input(event):
	if event.is_action_pressed("ui_accept"):
		get_tree().reload_current_scene()
