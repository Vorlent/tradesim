extends "res://ai/AIAction.gd"

var gathered : bool = false
 
var start_time : float = 0
var gathering_duration : float = 2

func _init():
	add_precondition("has_tool", true)
	add_precondition("has_ore", false)
	add_effect("has_ore", true) 
 
func is_done() -> bool:
	return gathered
 
func requires_in_range ():
	return true

func check_procedural_precondition(agent) -> bool:
	# find a suitable rock to mine
	return true
 
func perform_action(agent) -> bool:
	# do mining
	return true
