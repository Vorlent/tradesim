extends KinematicBody2D

signal target_reached
signal path_changed(path)

export (int) var MAX_SPEED = 100

var velocity = Vector2()

onready var up_sprite = $RightUp
onready var down_sprite = $RightDown

onready var navigation_agent = $NavigationAgent2D

onready var active_sprite : AnimatedSprite = $RightUp

var did_arrive : bool = true

func set_target_location(target: Vector2) -> void:
	did_arrive = false
	navigation_agent.set_target_location(target)

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
		# set animation based on motion
		var old_sprite : AnimatedSprite = active_sprite
		if velocity.y < 0: # up
			active_sprite = up_sprite
		elif velocity.y > 0: # down
			active_sprite = down_sprite
		# else: idle
		
		old_sprite.hide()
		active_sprite.show()
			
		if velocity.x < 0: # left
			active_sprite.flip_h = 1
			active_sprite.play()
		elif velocity.x > 0: # right
			active_sprite.flip_h = 0
			active_sprite.play()
		else: # idle
			active_sprite.stop()
			active_sprite.frame = 0
		
		if active_sprite != old_sprite:
			old_sprite.stop()
			
		velocity = move_and_slide(velocity)
	elif not did_arrive:
		did_arrive = true
		emit_signal("path_changed", [])
		emit_signal("target_reached")
		
		active_sprite.stop()
		active_sprite.frame = 0
	
func _on_NavigationAgent2D_path_changed():
	emit_signal("path_changed", navigation_agent.get_nav_path())
