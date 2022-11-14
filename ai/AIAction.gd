extends Reference

class_name AIAction

enum HumanTaskType {
	HUMAN_WAIT, HUMAN_WALK,
	HUMAN_GATHER, HUMAN_EAT,
	HUMAN_DRINK, HUMAN_BUILD,
	HUMAN_SLEEP
}

var preconditions : Dictionary = {}
var effects : Dictionary = {}
var cost : float = 100.0

var target_position : Vector2
var target_in_range : bool = false
var goal_finished : bool
var g : Node # reference to autoload

func wait_goal():
	return self

# Constructor
func _init():
	pass

func reset():
	target_in_range = false

func perform_action(_human, _delta):
	pass
	
func get_target_position():
	return target_position

func requires_in_range():
	return false

func in_range(_agent_position : Vector2) -> bool:
	return target_in_range

func set_in_range():
	target_in_range = true

func is_done() -> bool:
	return false

func check_procedural_precondition(_agent) -> bool:
	return true

# value = true means the effect must be present
# value = false means the effect isn't allowed to be present
func add_precondition(precondition : String, value):
	preconditions[precondition] = value

func remove_precondition(precondition : String):
	var _u = preconditions.erase(precondition)

# value = true means the effect will be added to the current state
# value = false means the effect will be removed from the current state
func add_effect(effect : String, value):
	effects[effect] = value

func remove_effect(effect : String):
	var _u = effects.erase(effect)
