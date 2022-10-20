extends KinematicBody2D

signal gather_selection(tree)

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event.is_action("gather_target") and event is InputEventMouseButton:
		print("GATHER TREE")
		emit_signal("gather_selection", self)
