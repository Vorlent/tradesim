extends Node2D


onready var TerrainL1 : TileMap = $TerrainL1

# Called when the node enters the scene tree for the first time.
func _ready():
	tilemap_to_data(TerrainL1)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

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
