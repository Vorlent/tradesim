extends "res://ai/AIAction.gd"

class_name GatherWoodAction

const Tree = preload("res://terrain/Tree.gd")
const Units = preload("res://ai/Units.gd")
const Item = preload("res://ai/Item.gd")
const ItemStack = preload("res://ai/ItemStack.gd")

var gathered : bool = false
 
var time_spent : float = 0
var gathering_duration : float = 2

var inv_text = ""

func _init():
	add_effect("has_wood", true)
	cost = 10.0

func reset():
	gathered = false
	time_spent = 0
 
func is_done() -> bool:
	return gathered
 
func requires_in_range ():
	return true

func check_procedural_precondition(agent) -> bool:
	# find a suitable tree to cut
	var closest_distance : float = 99999999.0
	var closest_object = null
	for object in agent.game.object_container.get_children():
		if object is Tree:
			var distance = agent.position.distance_squared_to(object.position)
			if distance < closest_distance:
				closest_distance = distance
				closest_object = object
	if closest_object:
		target_position = closest_object.position
		return true
	return false
 
func perform_action(agent, delta) -> bool:
	time_spent += delta
	
	var progress = time_spent / gathering_duration * 100
	if progress > 100.0:
		gathered = true
		progress = 100.0
		add_item(agent)
	
	agent.ai_label.text = "Gathering Wood " + Units.format_percentage(progress) + " " + inv_text
	# do mining
	return true

func add_item(agent):
	var item_type = G.Items(agent).OAK_WOOD
	var wood_item_stack = ItemStack.new(item_type, item_type.amount_from_weight(Units.kg(5)))
	agent.left_hand_item_slot.put_itemstack(wood_item_stack)
	inv_text = str(agent.left_hand_item_slot)
