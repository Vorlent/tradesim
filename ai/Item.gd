extends Reference

# An item is a definition that can be used to describe the behavior, appearance and function of an
# in-game interactable object

# solids including sand or grains or crushed rock have a fixed volume of 1cm^3
# liquids have a fixed volume of 1mL
# discrete objects have arbitrary weights and volumes

class_name Item

var weight : float = 0 # kg
var volume : float = 0 # m^3

var name : String = ""
var stackable : bool = true
var divisible : bool = false # whether something can be split up arbitrarilyy
var min_quantity : int = 1 # smallest quantity that something can be split up

# associated icon?

func _init(name_ : String):
	self.name = name_

# density is kg/m^3
func density(density : float):
	self.volume = Units.cm3(1)
	self.weight = volume * density
	return self

func stackability(stackable_ : bool):
	self.stackable = stackable_
	return self

func divisibility(divisible_ : bool):
	self.divisible = divisible_
	return self

# rounded down
func amount_from_weight(specified_weight : float) -> int:
	print("weight: " , weight , " specified_weight " , specified_weight, "result: ", weight / specified_weight)
	return int(floor(specified_weight / weight))

# rounded down
func amount_from_volume(specified_volume : float) -> int:
	return int(floor(specified_volume / volume))

func _to_string():
	return "Item." + name
