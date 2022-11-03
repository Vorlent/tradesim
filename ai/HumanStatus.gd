extends Reference

class_name HumanStatus

var max_health : float = 1.0
var health : float = 1.0 # 0.0 to 1.0

var age : float = 0.0 # age in seconds

var overburdened : float = 0 # 0.0 to 1.0
var exhaustion : float = 0 # 0.0 to 1.0
var hunger : float = 0 # 0.0 to 1.0
var thirst : float = 0 # 0.0 to 1.0
var sleepiness : float = 0 # 0.0 to 1.0

var body_temperature : float = 37.0

var injured : float = 0 # 0.0 to 1.0
var pain : float = 0 # 0.0 to 1.0
var fever : float = 0 # 0.0 to 1.0
var cold : float = 0 # 0.0 to 1.0

var game

var hunger_depletion_rate : float = 1.0 / WorldClock.days(7)
var thirst_depletion_rate : float = 1.0 / WorldClock.days(3)
var sleep_depletion_rate : float = 1.0 / WorldClock.days(1) # must sleep at 33%

var thirst_health_depletion_rate : float = 1.0/WorldClock.hours(12)
var hunger_health_depletion_rate : float = 1.0/WorldClock.hours(12)
var sleep_health_depletion_rate : float = 1.0/WorldClock.days(7)

var health_recovery_rate : float = 1.0/WorldClock.days(5)

func _init(game_):
	self.game = game_

func _ready():
	pass

func _process(delta):
	age += delta * game.world_clock.time_scale
	
	hunger += hunger_depletion_rate * delta * game.world_clock.time_scale
	thirst += thirst_depletion_rate * delta * game.world_clock.time_scale
	sleepiness += sleep_depletion_rate * delta * game.world_clock.time_scale
	
	var damage_health : bool = false
	
	# damage health when thirst above 1.0
	if thirst > 1.0:
		health -= sleep_health_depletion_rate * delta * game.world_clock.time_scale
		damage_health = true
	
	if hunger > 1.0:
		health -= hunger_health_depletion_rate * delta * game.world_clock.time_scale
		damage_health = true
	
	if sleepiness > 0.80:
		health -= sleep_health_depletion_rate * delta * game.world_clock.time_scale
		damage_health = true
	
	# recover all health within 5 days if no damage is taken
	if not damage_health and health < 1.0:
		health += health_recovery_rate * delta * game.world_clock.time_scale
	if health > 1.0:
		health = 1.0
	
	pass
