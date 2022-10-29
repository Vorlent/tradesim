extends Reference

# An item is a physical manifestation of a material
# or a complex combination of different materials
# whose sum is greater than its parts

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

func material_by_volume(material : ItemMaterial, specified_volume : float):
	var amount = material.amount_from_volume(specified_volume)
	weight = material.weight * amount
	volume = specified_volume
	return self

func material_by_weight(material : ItemMaterial, specified_weight : float):
	var amount = material.amount_from_weight(specified_weight)
	weight = specified_weight
	volume = material.volume * amount
	return self

func stackability(stackable_ : bool):
	self.stackable = stackable_
	return self

func divisibility(divisible_ : bool):
	self.divisible = divisible_
	return self

func _to_string():
	return "Item." + name
