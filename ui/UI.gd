extends CanvasLayer

signal create_plan(goal)

var has_wood : bool = true
var has_crop : bool = true

func _ready():
	$Panel/GatherWood.pressed = has_wood
	$Panel/GatherCrop.pressed = has_crop
	pass # Replace with function body.

func _on_GatherWood_toggled(button_pressed):
	has_wood = button_pressed


func _on_GatherCrop_toggled(button_pressed):
	has_crop = button_pressed

func _on_CreatePlan_pressed():
	var goal = {
		has_wood = has_wood,
		has_crop = has_crop,
	}
	emit_signal("create_plan", goal)
