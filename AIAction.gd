extends Object

class_name AIAction

enum HumanTaskType {
	HUMAN_WAIT, HUMAN_WALK,
	HUMAN_GATHER, HUMAN_EAT,
	HUMAN_DRINK, HUMAN_BUILD,
	HUMAN_SLEEP
}

var preconditions : Dictionary = {}
var effects : Dictionary = {}
var cost : float = 1.0

var goal_type
var goal_position : Vector2
var goal_finished : bool

func wait_goal():
	goal_type = HumanTaskType.HUMAN_WAIT
	return self

func gather_goal(navigation_agent : NavigationAgent2D, position : Vector2):
	goal_type = HumanTaskType.HUMAN_GATHER
	self.navigation_agent = navigation_agent
	navigation_agent.set_target_location(position)
	goal_position = position
	return self

# Constructor
func _init():
	pass

func perform_action(human):
	pass

func is_done() -> bool:
	return false

func check_procedural_precondition(agent) -> bool:
	return true

# value = true means the effect must be present
# value = false means the effect isn't allowed to be present
func add_precondition(precondition : String, value):
	preconditions[precondition] = value

func remove_precondition(precondition : String):
	preconditions.erase(precondition)

# value = true means the effect will be added to the current state
# value = false means the effect will be removed from the current state
func add_effect(effect : String, value):
	effects[effect] = value

func remove_effect(effect : String):
	effects.erase(effect)
