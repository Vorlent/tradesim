extends Node2D

onready var ui = $UI
onready var game = $Game

func _ready():
	ui.game = game
