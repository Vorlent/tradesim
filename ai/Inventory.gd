extends Reference

# an inventory is a container several unnamed item slots
class_name Inventory

signal mark_dirty(inventory)

var unnamed_item_slots : Array = []

func _init():
	pass

func put_itemstack(new_item_stack : ItemStack) -> bool:
	print(new_item_stack)
	for old_item in unnamed_item_slots:
		var old_item_type = old_item.item_stack.item_type
		if old_item_type == null or old_item_type == new_item_stack.item_type:
			var amount = old_item.remaining_capacity(new_item_stack)
			old_item.put_itemstack(new_item_stack.split(amount))
			print("old_item: ", old_item)
	
	while new_item_stack.current_amount > 0:
		var new_slot = ItemSlot.new(5, Units.kg(50), Units.dm3(1000))
		var amount = new_slot.remaining_capacity(new_item_stack)
		new_slot.put_itemstack(new_item_stack.split(amount))
		print("new_slot: ", new_slot)
		unnamed_item_slots.append(new_slot)
	
	emit_signal("mark_dirty", self)
	return new_item_stack.current_amount == 0

# try removing an item stack from the slot
# if sufficient quantities exist
# returns null if it is not possible
func remove_itemstack(item_type, amount) -> ItemStack:
	var filled_amount = 0
	var remaining = amount
	for old_item in unnamed_item_slots:
		if old_item.item_type == item_type:
			if remaining > 0:
				var removable_amount = min(remaining, old_item.current_amount)
				old_item.current_amount -= removable_amount
				if old_item.current_amount == 0:
					old_item.item_type = null
				remaining -= removable_amount
				filled_amount += removable_amount
				
	
	emit_signal("mark_dirty", self)
	return ItemStack.new(item_type, filled_amount)

func _to_string() -> String:
	return "inventory: " + str(unnamed_item_slots.size())
