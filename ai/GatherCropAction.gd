extends "res://ai/AIAction.gd"

class_name GatherCropAction

const Tree = preload("res://terrain/Tree.gd")

var gathered : bool = false
 
var time_spent : float = 0
var gathering_duration : float = 2
var target_object

func _init():
	add_effect("has_crop", true)
	cost = 9.0

func reset():
	.reset()
	gathered = false
	time_spent = 0
 
func is_done() -> bool:
	return gathered
 
func requires_in_range ():
	return true

func check_procedural_precondition(agent) -> bool:
	# find a suitable tree to cut
	var closest_distance : float = 99999999.0
	target_object = null
	for object in agent.game.object_container.get_children():
		if object is Crop:
			var distance = agent.position.distance_squared_to(object.position)
			if distance > 500*0 and distance < closest_distance:
				closest_distance = distance
				target_object = object
	if target_object:
		target_position = target_object.position
		if target_object.has_node("NavigationDestination"):
			target_position += target_object.get_node("NavigationDestination").position	
		return true
	return false
 
func perform_action(agent, delta) -> bool:
	time_spent += delta
	
	var progress = time_spent / gathering_duration * 100
	if progress > 100.0:
		gathered = true
		progress = 100.0
		add_item(agent)
	
	agent.ai_label.text = "Gathering Crop " + Units.format_percentage(progress)
	# do mining
	return true

func add_item(agent):
	var item_type = target_object.harvestable_crop
	var crop_item_stack = ItemStack.new(item_type, 1)
	#agent.left_hand_item_slot.put_itemstack(crop_item_stack)
	agent.inventory.put_itemstack(crop_item_stack)

func _to_string():
	return "GatherCropAction"
