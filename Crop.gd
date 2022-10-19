extends KinematicBody2D

onready var sprite_container = $SpriteContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	var possible_sprites = sprite_container.get_children()
	var random_sprite : int = int(rand_range(0, possible_sprites.size() - 1))
	possible_sprites[random_sprite].show()
