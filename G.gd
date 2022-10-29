extends Node

class_name G

static func ItemMaterials(g_):
	return g_.get_tree().root.get_node("/root/ItemMaterials")

static func Items(g_):
	return g_.get_tree().root.get_node("/root/Items")
