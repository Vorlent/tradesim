extends Node

class_name WorldClock

var time_scale : float = 1.0 # in-game seconds per second

# 1 ingame second per real second
var REAL_TIME : float = 1.0

# 1 ingame day per 30 real minutes
var SLOW_SPEED : float = days(1) / minutes(30)

# 1 ingame day per 12 real minutes
var NORMAL_SPEED : float = days(1) / minutes(12)

# 1 ingame day per 3 real minutes
var FAST_SPEED : float = days(1) / minutes(3)

# I don't know enough about history to pick a specific date
# so I will pick the date almost nobody who invents a new calendar picks.
var year : int = 0
var month : int = 1
var day : int = 1

var hour : int = 0
var minute : int = 0
var second : float = 0

var absolute_seconds : float = 0 # time since year 0 in seconds

const DAYS_PER_YEAR = 360
const MONTHS_PER_YEAR = 12
const DAYS_PER_MONTH = 30

const HOURS_PER_DAY = 24
const MINUTES_PER_HOUR = 60
const SECONDS_PER_MINUTE = 60

func get_min_speed_level():
	return 2

func get_max_speed_level():
	return 4

func set_speed_level(speed_level):
	if speed_level == 1:
		time_scale = REAL_TIME
	elif speed_level == 2:
		time_scale = SLOW_SPEED
	elif speed_level == 3:
		time_scale = NORMAL_SPEED
	elif speed_level == 4:
		time_scale = FAST_SPEED
	else:
		time_scale = NORMAL_SPEED

func _ready():
	time_scale = NORMAL_SPEED

func _process(delta):
	absolute_seconds += delta * time_scale
	var absolute_minutes : int = int(floor(absolute_seconds / SECONDS_PER_MINUTE))
	var absolute_hours : int = int(floor(absolute_minutes / MINUTES_PER_HOUR))
	var absolute_days : int = int(floor(absolute_hours / HOURS_PER_DAY))
	var absolute_months : int = int(floor(absolute_days / DAYS_PER_MONTH))
	var absolute_years : int = int(floor(absolute_months / MONTHS_PER_YEAR))
		
	second = fmod(absolute_seconds, SECONDS_PER_MINUTE)
	minute = absolute_minutes % MINUTES_PER_HOUR

	hour = absolute_hours % HOURS_PER_DAY
	day = absolute_days % DAYS_PER_MONTH + 1
	month = absolute_months % MONTHS_PER_YEAR + 1
	year = absolute_years

static func month_name(month : int):
	var month_names = [
		"January",
		"Feburary",
		"March",
		"April",
		"May",
		"June",
		"July",
		"August",
		"September",
		"October",
		"November",
		"December"
	]
	return month_names[month - 1]

func format_day(day : int):
	if day == 1:
		return "1st"
	elif day == 2:
		return "2nd"
	elif day == 3:
		return "3rd"
	else:
		return "%dth" % day

func _to_string():
	return "%s %s %d %02d:%02d" % [format_day(day), month_name(month), year, hour, minute]

static func days(amount : float) -> float:
	return amount * HOURS_PER_DAY * MINUTES_PER_HOUR * SECONDS_PER_MINUTE

static func hours(amount : float) -> float:
	return amount * MINUTES_PER_HOUR * SECONDS_PER_MINUTE
	
static func minutes(amount : float) -> float:
	return amount * SECONDS_PER_MINUTE

static func seconds(amount : float) -> float:
	return amount
