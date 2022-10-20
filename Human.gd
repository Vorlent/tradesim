extends KinematicBody2D

const WalkingSprite = preload("res://WalkingSprite.gd")

signal target_reached
signal path_changed(path)

export (int) var MAX_SPEED = 100

var velocity = Vector2()
onready var navigation_agent = $NavigationAgent2D
var walking_sprite : WalkingSprite

var did_arrive : bool = true

func set_target_location(target: Vector2) -> void:
	did_arrive = false
	navigation_agent.set_target_location(target)
	
func _ready():
	walking_sprite = WalkingSprite.new(self, $RightUp, $RightDown)

func _arrived_at_location() -> bool:
	return navigation_agent.is_navigation_finished()

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
	
	if did_arrive:
		return
		
	var move_direction = position.direction_to(navigation_agent.get_next_location())
	velocity = move_direction * MAX_SPEED
	navigation_agent.set_velocity(velocity)

	if not _arrived_at_location():
		walking_sprite.start_walking()
		velocity = move_and_slide(velocity)
	elif not did_arrive:
		did_arrive = true
		emit_signal("path_changed", [])
		emit_signal("target_reached")
		
		walking_sprite.stop_walking()
	
func _on_NavigationAgent2D_path_changed():
	emit_signal("path_changed", navigation_agent.get_nav_path())
