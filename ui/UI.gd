extends CanvasLayer

signal create_plan(ui, goal)

onready var gather_wood_button : CheckButton = $Panel/Tabs/AI/GatherWood
onready var gather_crop_button : CheckButton = $Panel/Tabs/AI/GatherCrop
onready var sleep_button : CheckButton = $Panel/Tabs/AI/Sleep
onready var action_list : ItemList = $Panel/Tabs/AI/ActionList
onready var item_list : ItemList = $Panel/Tabs/Inventory/ItemList
onready var time_label : Label = $BottomBar/TimeLabel
onready var speed_slider : HSlider = $BottomBar/SpeedSlider

var has_wood : bool = true
var has_crop : bool = true
var slept : bool = true
var agent
var game

func _ready():
	gather_wood_button.pressed = has_wood
	gather_crop_button.pressed = has_crop
	sleep_button.pressed = slept

func _process(delta):
	time_label.text = str(game.world_clock)
	if game.human:
		var human_status = game.human.human_status
		
		$Panel/Tabs/Status/HealProgressBar.value = human_status.health * 100.0
		$Panel/Tabs/Status/OverburdenedProgressBar.value = human_status.overburdened * 100.0
		$Panel/Tabs/Status/ExhaustionProgressBar.value = human_status.exhaustion * 100.0
		$Panel/Tabs/Status/HungerProgressBar.value = human_status.hunger * 100.0
		$Panel/Tabs/Status/ThirstProgressBar.value = human_status.thirst * 100.0
		$Panel/Tabs/Status/SleepinessProgressBar.value = human_status.sleepiness * 100.0
		$Panel/Tabs/Status/InjuredProgressBar.value = human_status.injured * 100.0
		$Panel/Tabs/Status/PainProgressBar.value = human_status.pain * 100.0
		$Panel/Tabs/Status/FeverProgressBar.value = human_status.fever * 100.0
		$Panel/Tabs/Status/ColdProgressBar.value = human_status.cold * 100.0
		
		$Panel/Tabs/Status/AgeValueLabel.text = WorldClock.format_time(human_status.age)
		
		# $Panel/Tabs/Status/BodyTemperature.value = human_status.body_temperature
		# $Panel/Tabs/Status/BodyTemperature.value = human_status.age

func _on_GatherWood_toggled(button_pressed):
	has_wood = button_pressed

func _on_GatherCrop_toggled(button_pressed):
	has_crop = button_pressed

func _on_Sleep_toggled(button_pressed):
	slept = button_pressed


func _on_CreatePlan_pressed():
	var goal = {
		has_wood = has_wood,
		has_crop = has_crop,
		slept = slept
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

func _on_SpeedSlider_value_changed(value):
	var speed_level = int(value)
	game.world_clock.set_speed_level(speed_level)
