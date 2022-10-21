extends Object

class_name AIGoal

enum HumanTaskType {
	HUMAN_WAIT, HUMAN_WALK,
	HUMAN_GATHER, HUMAN_EAT,
	HUMAN_DRINK, HUMAN_BUILD,
	HUMAN_SLEEP
}

var goal_type
var goal_position : Vector2
var goal_finished : bool

# walk_goal specific
var navigation_agent : NavigationAgent2D
var did_arrive : bool
var walking_sprite

func wait_goal():
	goal_type = HumanTaskType.HUMAN_WAIT
	return self

func walk_goal(navigation_agent : NavigationAgent2D, position : Vector2):
	goal_type = HumanTaskType.HUMAN_WALK
	self.navigation_agent = navigation_agent
	navigation_agent.set_target_location(position)
	goal_position = position
	did_arrive = false
	return self

# Constructor
func _init():
	pass

func process_ai(human):
	if goal_type == HumanTaskType.HUMAN_WALK:
		if did_arrive:
			return
			
		var move_direction = human.position.direction_to(navigation_agent.get_next_location())
		human.velocity = move_direction * human.MAX_SPEED
		navigation_agent.set_velocity(human.velocity)

		if not _arrived_at_location():
			human.walking_sprite.start_walking()
			human.velocity = human.move_and_slide(human.velocity)
		elif not did_arrive:
			did_arrive = true
			human.emit_signal("path_changed", [])
			human.emit_signal("target_reached")
			
			human.walking_sprite.stop_walking()

func _arrived_at_location() -> bool:
	return navigation_agent.is_navigation_finished()

func goal_complete() -> bool:
	if goal_type == HumanTaskType.HUMAN_WALK:
		return navigation_agent.is_navigation_finished()
	return goal_finished
