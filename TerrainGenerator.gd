extends Object

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
var navpoly : NavigationPolygon
var object_container

var negative_polygon : Array = []

# Constructor
func _init(tilemap : TileMap, navpoly: NavigationPolygon, object_container):
	self.tilemap = tilemap
	self.object_container = object_container
	self.openSimplexNoise = OpenSimplexNoise.new()
	self.navpoly = navpoly
	init_tiles(tilemap)

func init_tiles(tilemap : TileMap):
	tiles = {
		"grass": tilemap.tile_set.find_tile_by_name("generic_dirt"),
		"sand": tilemap.tile_set.find_tile_by_name("sand"),
		"water": tilemap.tile_set.find_tile_by_name("water"),
		"stone": tilemap.tile_set.find_tile_by_name("stone")
	}

var object_tiles = {
	"tree": preload("res://Tree.tscn"),
	"rock": preload("res://Rock.tscn"),
	"bush": preload("res://Bush.tscn"),
	"crop": preload("res://Crop.tscn")
}

var biome_data = {
	"plains": { "grass": 1 },
	"lake": { "water": 1 },
	"mountain": { "stone": 0.98, "grass":0.02 },
	"ocean": { "water": 1 }
}

var object_data = {
	"plains": { "tree": 0.03, "rock": 0.01, "bush": 0.02, "crop": 0.01 },
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
	
const BOTTOM_RIGHT = 1
const TOP_LEFT = 2
const BOTTOM_LEFT = 4
const TOP_RIGHT = 8
	
func generate_tilemap():
	var edge_tiles : Array = []
	for x in width:
		for y in height:
			var pos = Vector2(x, y)
			var alt = altitude[pos]
			var temp = temperature[pos]
			var moist = moisture[pos]
			
			biome[pos] = get_biome(alt, temp, moist)
			#tilemap.set_cellv(pos, tiles[random_tile(biome_data, biome[pos])])
			
			if tilemap.get_cellv(pos) == tiles["grass"]:
				# check all 4 directions
				# if one is not covered then this tile is an edge tile
				var edges_covered : int = 0
				# bottom right edge
				if tilemap.get_cell(pos.x + 1, pos.y) == tiles["grass"]:
					edges_covered += BOTTOM_RIGHT
				if tilemap.get_cell(pos.x - 1, pos.y) == tiles["grass"]:
					edges_covered += TOP_LEFT
				if tilemap.get_cell(pos.x, pos.y + 1) == tiles["grass"]:
					edges_covered += BOTTOM_LEFT
				if tilemap.get_cell(pos.x, pos.y - 1) == tiles["grass"]:
					edges_covered += TOP_RIGHT
				if edges_covered < BOTTOM_RIGHT+TOP_LEFT+BOTTOM_LEFT+TOP_RIGHT:
					edge_tiles.append(Vector3(pos.x, pos.y, edges_covered))
			
	var edge_by_start : Dictionary = {}
	
	for pos in edge_tiles:
		var pos2 = Vector2(pos.x, pos.y)
		var edges_covered = int(pos.z)
		if edges_covered & BOTTOM_RIGHT == 0:
			edge_line(pos2, Vector2(1, 0), Vector2(1, 1), edge_by_start)
		if edges_covered & TOP_LEFT == 0:
			edge_line(pos2, Vector2(0, 1), Vector2(0, 0), edge_by_start)
		if edges_covered & BOTTOM_LEFT == 0:
			edge_line(pos2, Vector2(1, 1), Vector2(0, 1), edge_by_start)
		if edges_covered & TOP_RIGHT == 0:
			edge_line(pos2, Vector2(0, 0), Vector2(1, 0), edge_by_start)
		
	var array_of_outlines : Array = [] # each outline consists of an array of edges
	
	while not edge_by_start.empty():
		var start : Vector2 = edge_by_start.keys().front()
		var outline : PoolVector2Array = PoolVector2Array([start])
		var current : Vector2 = edge_by_start[start]
		edge_by_start.erase(start)
		var previous : Vector2 = start
		
		while current and current != start:
			var next = edge_by_start[current]
			if tile_step(previous, current) != tile_step(current, next):
				outline.append(current)
			edge_by_start.erase(current)
			previous = current
			current = next
		
		if current == start:
			outline.append(start)
			array_of_outlines.append(outline)
		if not current:
			print("FAILED TO REACH START!!")
	
	var colors = [Color(1.0, 0.0, 0.0, 1.0),
		  Color(0.0, 1.0, 0.0, 1.0),
		  Color(0.0, 0.0, 1.0, 1.0)]
		
	var next_color : int = 0
	
	navpoly.clear_outlines()
	navpoly.clear_polygons()
	for outline in array_of_outlines:
		navpoly.add_outline(outline)
		
		for i in len(outline) - 1:
			var edgeLine2D : Line2D = Line2D.new()
			edgeLine2D.width = 2
			edgeLine2D.default_color = colors[next_color % colors.size()]
			
			edgeLine2D.add_point(outline[i])
			edgeLine2D.add_point(outline[i+1])
			object_container.add_child(edgeLine2D)
			next_color += 1
	navpoly.make_polygons_from_outlines()
	# trigger auto tiling
	# tilemap.update_bitmask_region()
	# update nav mesh
	# tilemap.update_dirty_quadrants()
	
func tile_step(start, end) -> Vector2: 
	return tilemap.world_to_map(start) - tilemap.world_to_map(end)
	
func edge_line(pos : Vector2, start : Vector2, end : Vector2, edge_by_start : Dictionary):
	edge_by_start[tilemap.map_to_world(pos + start)] = tilemap.map_to_world(pos + end)

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
	negative_polygon = []
	for pos in biome:
		var current_biome = biome[pos]
		var random_object = random_tile(object_data, current_biome)
		objects[pos] = random_object
		if random_object != null:
			tile_to_scene(random_object, pos)

	#for old_polygon in negative_polygon:
	#	for new_polygon in negative_polygon:
	#		if old_polygon == new_polygon:
	#			continue
	#		var m = Geometry.merge_polygons_2d(old_polygon, new_polygon)
	#		if m:
	#			print(old_polygon, " ", new_polygon, " ", m)
	#			#var new_polygons = Geometry.merge_polygons_2d(old_polygon, transformed_polygon)
	#			#print(new_polygons)
	#			#new_negative_polygon.append_array(new_polygons)
	
	for polygon in negative_polygon:
		navpoly.add_outline(polygon)
	navpoly.make_polygons_from_outlines()
	negative_polygon = []

func tile_to_scene(random_object, pos):
	var instance = object_tiles[str(random_object)].instance()
	instance.position = tilemap.map_to_world(pos) + Vector2(4, 4)
	object_container.add_child(instance)
	
	var collision_polygon : CollisionPolygon2D = instance.find_node("NavigationPolygon2D")
	if collision_polygon:
		var deleted_polygons : Array = []
		var polygon_transform = instance.get_global_transform()
		var transformed_polygon = PoolVector2Array([])
		var scale : float = 2.0
		
		for vertex in collision_polygon.polygon:
			transformed_polygon.append(polygon_transform.xform(vertex))
			
		#navpoly.add_outline(transformed_polygon)
		negative_polygon.append(transformed_polygon)
		
		
