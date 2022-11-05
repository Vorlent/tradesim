extends Reference

signal timer_ended

class_name TimedProgress

var game
var start_time : float
var end_time : float
var duration : float = 0
var enabled : bool = false

func _init(game_):
	self.game = game_

func set_duration(seconds : float):
	duration = seconds

func start():
	enabled = true
	start_time = game.world_clock.absolute_seconds
	end_time = start_time + duration

func get_progress() -> float:
	return min(1.0, (end_time - game.world_clock.absolute_seconds) / duration)

func _process(delta):
	if enabled and game.world_clock.absolute_seconds <= end_time:
		enabled = false
		emit_signal("timer_ended")
