extends "res://ai/AIAction.gd"

class_name MiningAction

var mined : bool = false
var targetRock #: IronRockComponent
 
var startTime : float = 0
var miningDuration : float = 2

func _init():
	add_precondition("has_tool", true)
	add_precondition("has_ore", false)
	add_effect("has_ore", true) 
	 
func reset ():
	mined = false
	targetRock = null
	startTime = 0
 
func is_done() -> bool:
	return mined
 
func requires_in_range ():
	return true

func check_procedural_precondition(agent) -> bool:
	# find a suitable rock to mine
	return true
 
func perform_action(agent, delta) -> bool:
	# do mining
	return true
