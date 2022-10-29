extends Reference

class_name AIPlanNode

var parent : AIPlanNode
var running_cost : float
var state : Dictionary
var action : AIAction

func _init(parent_ : AIPlanNode, running_cost_ : float, state_ : Dictionary, action_ : AIAction):
	self.parent = parent_
	self.running_cost = running_cost_
	self.state = state_
	self.action = action_
