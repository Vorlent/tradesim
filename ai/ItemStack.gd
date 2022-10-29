extends Reference

class_name ItemStack
# An item stack is an instance of an item

var current_amount : int = 0
var item_type : Item

func _init(item : Item, amount : int):
	self.item_type = item
	self.current_amount = amount

func current_weight() -> float:
	return item_type.weight * current_amount
	
func current_volume() -> float:
	return item_type.volume * current_amount 

func _to_string():
	return "ItemStack(" + item_type.to_string() \
		 + ", weight: " + Units.format_weight(current_weight()) \
		 + ", volume: " + Units.format_volume(current_volume()) + ")"
