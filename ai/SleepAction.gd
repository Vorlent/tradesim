extends "res://ai/AIAction.gd"

class_name SleepAction

var slept : bool = false
 
var time_spent : float = 0
var sleep_duration : float = WorldClock.hours(8)
var target_object

func _init():
	add_effect("slept", true)
	cost = 9.0

func reset():
	.reset()
	slept = false
	time_spent = 0
 
func is_done() -> bool:
	return slept
 
func requires_in_range ():
	return false

func check_procedural_precondition(agent) -> bool:
	# find a suitable place to sleep (TODO)
	return true
 
func perform_action(agent, delta) -> bool:
	var time_scale : float = agent.game.world_clock.time_scale
	time_spent += time_scale * delta
	
	if agent.human_status.sleepiness > 0:
		agent.human_status.sleepiness -= 4 * agent.human_status.sleep_depletion_rate * delta * time_scale
	
	var progress = time_spent / sleep_duration * 100
	if progress > 100.0:
		slept = true
		progress = 100.0
		agent.ai_label.text = ""
	else:	
		agent.ai_label.text = "Sleeping " + Units.format_percentage(progress)
	return true

func _to_string():
	return "SleepAction"
