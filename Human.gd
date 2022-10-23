extends KinematicBody2D

const WalkingSprite = preload("res://WalkingSprite.gd")
const AIAction = preload("res://AIAction.gd")
const WalkingAction = preload("res://WalkingAction.gd")
const AIPlanner = preload("res://AIPlanner.gd")

signal target_reached
signal path_changed(path)

export (int) var MAX_SPEED = 100

var velocity = Vector2()
onready var navigation_agent = $NavigationAgent2D
var walking_sprite : WalkingSprite

var did_arrive : bool = true

var ai_goal : AIAction = AIAction.new().wait_goal()

var ai_plan : Array = []
var ai_plan_index : int = -1

onready var available_actions : Array = [
	WalkingAction.new(navigation_agent, Vector2(350, 350))
]

func walk_to(target: Vector2) -> void:
	available_actions = [
		WalkingAction.new(navigation_agent, target)
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
		ai_plan = AIPlanner.plan(self, available_actions, {}, {"walked": true})
		ai_plan_index = 0
		print("generated plan: ", ai_plan)
	else:
		if ai_plan_index < ai_plan.size():
			var action = ai_plan[ai_plan_index]
			if action.is_done():
				ai_plan_index += 1
			else:
				action.perform_action(self)
		else:
			print("AI PLAN COMPLETE")
			ai_plan_index = -1

func _physics_process(_delta):
	if not visible:
		return
		
	#ai_goal.perform_action(self)
	
func _on_NavigationAgent2D_path_changed():
	emit_signal("path_changed", navigation_agent.get_nav_path())
