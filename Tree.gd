extends KinematicBody2D

signal gather_selection(tree)

func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if event.is_action("gather_target") and event is InputEventMouseButton:
		print("GATHER TREE")
		emit_signal("gather_selection", self)

func added_to_game(game : Node2D):
	connect("gather_selection", game, "_on_gather_selection")
