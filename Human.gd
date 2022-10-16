extends KinematicBody2D

export (int) var speed = 200

var velocity = Vector2()

onready var up_sprite = $RightUp
onready var down_sprite = $RightDown

onready var active_sprite : AnimatedSprite = $RightUp

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
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
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
