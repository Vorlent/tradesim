extends KinematicBody2D

class_name Human

signal target_reached
signal path_changed(path)

export (int) var MAX_SPEED = 100

var velocity = Vector2()
onready var navigation_agent = $NavigationAgent2D
onready var ai_label : Label = $AILabel
var walking_sprite : WalkingSprite

var did_arrive : bool = true

var walking_action : WalkingAction

var ai_plan : Array = []
var ai_plan_index : int = -1

var game # reference to the main scene

var left_hand_item_slot = ItemSlot.new(5, Units.kg(10), Units.dm3(250))
var right_hand_item_slot = ItemSlot.new(5, Units.kg(10), Units.dm3(250))

onready var available_actions : Array = [
	# WalkingAction.new(navigation_agent, Vector2(350, 350)),
	GatherWoodAction.new()
]

func walk_to(_target: Vector2) -> void:
	available_actions = [
		# WalkingAction.new(navigation_agent, target),
		GatherWoodAction.new()
	]
	
func _ready():
	walking_sprite = WalkingSprite.new(self, $RightUp, $RightDown)

func get_input():
	velocity = Vector2()
	var x_magnitude : float  = 1
	var y_magnitude : float  = 0.50
	
	if Input.is_action_pressed("right"):
		velocity.y += y_magnitude
		velocity.x += x_magnitude
	elif Input.is_action_pressed("left"):
		velocity.y -= y_magnitude
		velocity.x -= x_magnitude
	elif Input.is_action_pressed("down"):
		velocity.y += y_magnitude
		velocity.x -= x_magnitude
	elif Input.is_action_pressed("up"):
		velocity.y -= y_magnitude
		velocity.x += x_magnitude
	velocity = velocity.normalized() * MAX_SPEED

func _process(delta):
	# generate plan
	
	if ai_plan_index == -1:
		print("available actions ", available_actions)
		ai_plan = AIPlanner.plan(self, available_actions, {}, {"has_wood": true})
		ai_plan_index = 0
		print("generated plan: ", ai_plan)
	else:
		if ai_plan_index < ai_plan.size():
			var action = ai_plan[ai_plan_index]
			if action.is_done():
				action.reset()
				ai_plan_index += 1
			else:
				if walking_action and walking_action.is_done():
					print("finish walking")
					action.set_in_range()
					walking_action.perform_action(self, delta)
					walking_action = null
				if action.in_range(self.position):
					action.perform_action(self, delta)
				elif not walking_action: # walk to target
					walking_action = WalkingAction.new(navigation_agent, action.get_target_position())
		else:
			print("AI PLAN COMPLETE")
			ai_plan_index = -1

func _physics_process(delta):
	if not visible:
		return

	if walking_action:
		walking_action.perform_action(self, delta)
	
func _on_NavigationAgent2D_path_changed():
	emit_signal("path_changed", navigation_agent.get_nav_path())
