extends Reference

class_name WorldClock

var time_scale : float = 1.0 # in-game seconds per second

# I don't know enough about history to pick a specific date
# so I will pick the date almost nobody who invents a new calendar picks.
var year : int = 0
var month : int = 1
var day : int = 1

var hour : int = 0
var minute : int = 0
var second : float = 0

const DAYS_PER_YEAR = 360
const MONTHS_PER_YEAR = 12
const DAYS_PER_MONTH = 30

const HOURS_PER_DAY = 24
const MINUTES_PER_HOUR = 60
const SECONDS_PER_MINUTE = 60.0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	second += delta * time_scale

	minute += second / SECONDS_PER_MINUTE
	second = fmod(second, SECONDS_PER_MINUTE)
	
	hour += minute / MINUTES_PER_HOUR
	minute = minute % MINUTES_PER_HOUR
	
	day += hour / HOURS_PER_DAY
	hour = hour % HOURS_PER_DAY
	
	month += day / DAYS_PER_MONTH
	day = day % DAYS_PER_MONTH
	
	year += month / MONTHS_PER_YEAR
	month = month % MONTHS_PER_YEAR
		
	pass
