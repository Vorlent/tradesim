extends Reference

class_name ItemSlot

signal mark_dirty(item_slot)

# An item slot is a container for a single stackable item

var max_amount : int = 1
var max_weight : float = 10 # kilogram
var max_volume : float = 0.1 # m^3

var item_stack : ItemStack

func _init(amount, weight, volume):
	self.max_amount = amount
	self.max_weight = weight
	self.max_volume = volume
	#item_stack = ItemStack.new(G.Items(g).NO_ITEM)

func remaining_capacity(new_item_stack : ItemStack) -> int:
	var taken_up_amount = new_item_stack.current_amount
	var taken_up_weight = new_item_stack.current_weight()
	var taken_up_volume = new_item_stack.current_volume()
	
	if item_stack != null:
		if item_stack.item_type != new_item_stack.item_type:
			print("item mismatch")
			return 0
		taken_up_amount += new_item_stack.current_amount
		taken_up_weight += new_item_stack.current_weight()
		taken_up_volume += new_item_stack.current_volume()
		
	var remaining_amount = max(0, max_amount - taken_up_amount)
	var remaining_weight = max(0, max_weight - taken_up_weight)
	var remaining_volume = max(0, max_volume - taken_up_volume)

	var amount_by_weight = floor(remaining_weight / new_item_stack.item_type.weight)
	var amount_by_volume = floor(remaining_volume / new_item_stack.item_type.volume)	
	return int(min(remaining_amount, min(amount_by_weight, amount_by_volume)))

# try inserting an item stack into the slot
# false if there is an existing item in the slot and the new item type is different
# false if the max_amount, max_weight or max_volume constraint would be violated
# otherwise true
func put_itemstack(new_item_stack) -> bool:
	if remaining_capacity(new_item_stack) < new_item_stack.current_amount:
		return false
	
	if item_stack == null:
		item_stack = new_item_stack
	else:	
		item_stack.current_amount += new_item_stack.current_amount
	emit_signal("mark_dirty", self)
	return true

# try removing an item stack from the slot
# if sufficient quantities exist
# returns null if it is not possible
func remove_itemstack(amount) -> ItemStack:
	if item_stack == null:
		return null
	if item_stack.current_amount < amount:
		return null
	
	item_stack.current_amount -= amount
	emit_signal("mark_dirty", self)
	return ItemStack.new(item_stack.item_type, amount)

func _to_string() -> String:
	return str(item_stack)
