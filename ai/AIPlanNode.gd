extends Object

const AIAction = preload("res://ai/AIAction.gd")

class_name AIPlanNode

var parent : AIPlanNode
var running_cost : float
var state : Dictionary
var action : AIAction

func _init(parent : AIPlanNode, running_cost : float, state : Dictionary, action : AIAction):
	self.parent = parent
	self.running_cost = running_cost
	self.state = state
	self.action = action
