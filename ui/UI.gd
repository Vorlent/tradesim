extends CanvasLayer

signal create_plan(ui, goal)

onready var gather_wood_button : CheckButton = $Panel/Tabs/AI/GatherWood
onready var gather_crop_button : CheckButton = $Panel/Tabs/AI/GatherCrop
onready var action_list : ItemList = $Panel/Tabs/AI/ActionList
onready var item_list : ItemList = $Panel/Tabs/Inventory/ItemList

var has_wood : bool = true
var has_crop : bool = true
var agent

func _ready():
	gather_wood_button.pressed = has_wood
	gather_crop_button.pressed = has_crop
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
	emit_signal("create_plan", self, goal)

func visualize_plan(plan):
	print(plan)
	action_list.clear()
	for action in plan:
		action_list.add_item(str(action))


func _on_dirty_inventory(agent):
	print(agent.inventory)
	item_list.clear()
	for item in agent.inventory.unnamed_item_slots:
		
		var text = Units.format_weight(item.item_stack.current_weight()) \
			+ " " + Units.format_volume(item.item_stack.current_volume())
		
		item_list.add_item(text, item.item_stack.item_type.get_inventory_icon())
		var index = item_list.get_item_count() - 1
		item_list.set_item_tooltip(index, str(item.item_stack))
	print("DIRTY INVENTORY")
	pass # Replace with function body.
