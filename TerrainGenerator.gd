extends Node2D

export var width  = 50
export var height  = 50
var tilemap : TileMap
var temperature = {}
var moisture = {}
var altitude = {}
var biome = {}
var openSimplexNoise

var tiles = {}
var objects = {}
var object_container

# Constructor
func _init(tilemap : TileMap, object_container):
	self.tilemap = tilemap
	self.object_container = object_container
	self.openSimplexNoise = OpenSimplexNoise.new()
	init_tiles(tilemap)

func init_tiles(tilemap : TileMap):
	tiles = {
		"grass": tilemap.tile_set.find_tile_by_name("generic_dirt"),
		"sand": tilemap.tile_set.find_tile_by_name("sand"),
		"water": tilemap.tile_set.find_tile_by_name("water"),
		"stone": tilemap.tile_set.find_tile_by_name("stone")
	}

var object_tiles = {
	"tree": preload("res://Tree.tscn")
}

var biome_data = {
	"plains": { "grass": 1 },
	"lake": { "water": 1 },
	"mountain": { "stone": 0.98, "grass":0.02 },
	"ocean": { "water": 1 }
}

var object_data = {
	"plains": { "tree": 0.03 },
	"lake": {},
	"mountain": { "tree": 0.02 },
	"ocean": {}
}

func generate_map(per, oct):
	openSimplexNoise.seed = 5555
	openSimplexNoise.period = per
	openSimplexNoise.octaves = oct
	var gridName = {}
	for x in width:
		for y in height:
			gridName[Vector2(x,y)] = 2*(abs(openSimplexNoise.get_noise_2d(x,y)))
	return gridName
	
func get_biome(alt : float, temp : float, moist : float) -> String:
	#Ocean
	if alt < 0.25:
		return "ocean"
	#Other Biomes
	elif between(alt, 0.25, 0.8):
		#plains
		if between(moist, 0, 0.9):
			return "plains"
		#lakes
		elif moist >= 0.9:
			return "lake"
	#Mountains
	return "mountain"
	
func generate_tilemap():
	for x in width:
		for y in height:
			var pos = Vector2(x, y)
			var alt = altitude[pos]
			var temp = temperature[pos]
			var moist = moisture[pos]
			
			biome[pos] = get_biome(alt, temp, moist)
			#tilemap.set_cellv(pos, tiles[random_tile(biome_data, biome[pos])])
			
	# trigger auto tiling
	tilemap.update_bitmask_region()
	tilemap.update_dirty_quadrants()

func between(val, start, end):
	if start <= val and val < end:
		return true

func random_tile(data, biome):
	var current_biome = data[biome]
	var rand_num = rand_range(0,1)
	var running_total = 0
	for tile in current_biome:
		running_total = running_total+current_biome[tile]
		if rand_num <= running_total:
			return tile
				
func set_objects():
	objects = {}
	for pos in biome:
		var current_biome = biome[pos]
		var random_object = random_tile(object_data, current_biome)
		objects[pos] = random_object
		if random_object != null:
			tile_to_scene(random_object, pos)
			
func tile_to_scene(random_object, pos):
	var instance = object_tiles[str(random_object)].instance()
	instance.position = tilemap.map_to_world(pos) + Vector2(4, 4)
	object_container.add_child(instance)
