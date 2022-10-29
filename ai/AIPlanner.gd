extends Reference

class_name AIPlanner

# Generate a sequence of AI actions
static func plan(agent, available_actions, world_state, goal) -> Array:
	var usable_actions : Dictionary = {}
	for action in available_actions:
		if action.check_procedural_precondition(agent):
			usable_actions[action] = true
	
	#print("usable_actions ", usable_actions)

	var leaves : Array = []
	var start : AIPlanNode = AIPlanNode.new(null, 0, world_state, null)
	var success : bool = build_graph(start, leaves, usable_actions, goal)
	#print("leaves ", leaves, " success ", success)

	if not success:
		return [] # no plan

	# get the cheapest leaf
	var cheapest : AIPlanNode = null
	for leaf in leaves:
		if cheapest == null:
			cheapest = leaf
		else:
			if leaf.running_cost < cheapest.running_cost:
				cheapest = leaf

	# get its node and work back through the parents
	var result : Array = []
	var n : AIPlanNode = cheapest
	while n != null:
		if n.action != null:
			result.append(n.action)
		n = n.parent
	return result

# Generate a sub tree for each usable action based on what preconditions have been met
# Those actions then recursively create another subtree
# The effects of actions are accumulated and a leaf node will be generated when the goal effects
# have been satisfied
static func build_graph(parent : AIPlanNode, leaves : Array, usable_actions : Dictionary, goal : Dictionary):
	var found_one : bool = false
	for action in usable_actions.keys(): # Process all usable actions
		if subset_of(action.preconditions, parent.state):
			print(action)
			var current_state : Dictionary = populate_state(parent.state, {}, action.effects)
			var node : AIPlanNode = AIPlanNode.new(parent, parent.running_cost + action.cost, current_state, action)
			if subset_of(goal, current_state): # goal has been satisfied by current state
				leaves.append(node)
				found_one = true
			else: # goal has not been satisfied yet, build another subtree
				var subset : Dictionary = usable_actions.duplicate()
				var _u = subset.erase(action)
				if build_graph(node, leaves, subset, goal):
					found_one = true
	return found_one

# Checks if all elements in the subset are part of the superset
static func subset_of(subset : Dictionary, superset : Dictionary) -> bool:
	for t in subset.keys():
		if not superset.has(t) or subset[t] != superset[t]:
			return false
	return true

# Update current_state based on removed and added states
static func populate_state(current_state : Dictionary, state_remove : Dictionary, state_add : Dictionary) -> Dictionary:
	var state : Dictionary = current_state.duplicate()

	# remove old states
	for change in state_remove.keys():
		if state.has(change):
			var _u = state.erase(change)

	# add new states
	for change in state_add.keys():
		state[change] = state_add[change]
	return state
