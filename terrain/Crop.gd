extends KinematicBody2D

class_name Crop

onready var sprite_container = $SpriteContainer

onready var crop_items = [
	G.Items(self).CROP_TURNIP,
	G.Items(self).CROP_ROSE,
	G.Items(self).CROP_CUCUMBER,
	G.Items(self).CROP_TULIP,
	G.Items(self).CROP_TOMATO,
	G.Items(self).CROP_MELON,
	G.Items(self).CROP_EGGPLANT,
	G.Items(self).CROP_LEMON,
	G.Items(self).CROP_PINEAPPLE,
	G.Items(self).CROP_RICE,
	G.Items(self).CROP_WHEAT,
	G.Items(self).CROP_GRAPES,
	G.Items(self).CROP_STRAWBERRY,
	G.Items(self).CROP_CASSAVA,
	G.Items(self).CROP_POTATO,
	G.Items(self).CROP_COFFEE,
	G.Items(self).CROP_AVOCADO,
	G.Items(self).CROP_ORANGE,
	G.Items(self).CROP_CORN,
	G.Items(self).CROP_SUNFLOWER
]

var harvestable_crop : Item

# Called when the node enters the scene tree for the first time.
func _ready():
	var possible_sprites = sprite_container.get_children()
	var random_sprite : int = int(rand_range(0, possible_sprites.size() - 1))
	possible_sprites[random_sprite].show()
	harvestable_crop = crop_items[random_sprite]
