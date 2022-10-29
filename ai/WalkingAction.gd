extends "res://ai/AIAction.gd"

class_name WalkingAction

# walk_goal specific
var navigation_agent : NavigationAgent2D
var did_arrive : bool
var walking_sprite

# Constructor
func _init(navigation_agent_ : NavigationAgent2D, position : Vector2):
	add_effect("walked", true) 
	navigation_agent = navigation_agent_
	navigation_agent.set_target_location(position)
	did_arrive = false
	return self

func perform_action(human, _delta):
	if did_arrive:
		return true
		
	var move_direction = human.position.direction_to(navigation_agent.get_next_location())
	human.velocity = move_direction * min(2 * navigation_agent.distance_to_target(), human.MAX_SPEED)
	navigation_agent.set_velocity(human.velocity)

	if not _arrived_at_location():
		human.walking_sprite.start_walking()
		human.velocity = human.move_and_slide(human.velocity)
	elif not did_arrive:
		did_arrive = true
		human.emit_signal("path_changed", [])
		human.emit_signal("target_reached")
		
		human.walking_sprite.stop_walking()
	return true

func _arrived_at_location() -> bool:
	return navigation_agent.is_navigation_finished()

func is_done() -> bool:
	return _arrived_at_location()
 
func requires_in_range ():
	return true
