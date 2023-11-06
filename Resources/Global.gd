extends Node

@onready var splitscreen = get_node("/root/Node")
var current_level_node = null
var current_level = 1

func _ready():
	var root = get_tree().root
	current_level_node = root.get_child(root.get_child_count() - 1).get_node("HBoxContainer/LeftViewportContainer/LeftSubViewport").get_child(1)
	var current_level_scene = current_level_node.scene_file_path
	current_level = current_level_scene.to_int()
	
	
func change_scene(path):
	call_deferred("deferred_change_scene",path)
	
func deferred_change_scene(path):
	current_level_node.free()
	var next_scene = ResourceLoader.load(path)
	current_level_node = next_scene.instantiate()
	current_level_node.name = "Level " + str(current_level)
	var root = get_tree().root
	root.get_child(root.get_child_count() - 1).get_node("HBoxContainer/LeftViewportContainer/LeftSubViewport").add_child(current_level_node)
	splitscreen._ready()

