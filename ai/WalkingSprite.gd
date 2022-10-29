extends Node

class_name WalkingSprite

var up_sprite : AnimatedSprite
var down_sprite : AnimatedSprite
var human
var active_sprite : AnimatedSprite

# Constructor
func _init(human_, up_sprite_ : AnimatedSprite, down_sprite_ : AnimatedSprite):
	self.human = human_
	self.up_sprite = up_sprite_
	self.down_sprite = down_sprite_
	self.active_sprite = up_sprite_

func start_walking():
	# set animation based on motion
	var old_sprite : AnimatedSprite = active_sprite
	var velocity = human.velocity
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

func stop_walking():
	active_sprite.stop()
	active_sprite.frame = 0
