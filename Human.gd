extends KinematicBody2D

const WalkingSprite = preload("res://WalkingSprite.gd")
const AIGoal = preload("res://AIGoal.gd")

signal target_reached
signal path_changed(path)

export (int) var MAX_SPEED = 100

var velocity = Vector2()
onready var navigation_agent = $NavigationAgent2D
var walking_sprite : WalkingSprite

var did_arrive : bool = true

var ai_goal : AIGoal = AIGoal.new().wait_goal()

func walk_to(target: Vector2) -> void:
	ai_goal = AIGoal.new().walk_goal(navigation_agent, target)
	
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

func _physics_process(delta):
	if not visible:
		return
		
	ai_goal.process_ai(self)
	
func _on_NavigationAgent2D_path_changed():
	emit_signal("path_changed", navigation_agent.get_nav_path())
