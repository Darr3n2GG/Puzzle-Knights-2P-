extends Node

@onready var root = get_tree().root
var current_level_node = null
var current_level = 1

func setup_level() -> void:
	call_deferred("deferred_setup_level")
	
func deferred_setup_level() -> void:
	current_level_node = root.get_child(root.get_child_count() - 1).get_node("HBoxContainer/LeftViewportContainer/LeftSubViewport").get_child(1)
	var current_level_scene = current_level_node.scene_file_path
	current_level = current_level_scene.to_int()
	
func change_scene(path) -> void:
	call_deferred("deferred_change_scene",path)
	
func deferred_change_scene(path) -> void:
	current_level_node.free() #Problem 3: We can't proceed to level 2
	var next_scene = ResourceLoader.load(path)
	current_level_node = next_scene.instantiate()
	current_level_node.name = "Level " + str(current_level)
	root.get_child(root.get_child_count() - 1).get_node("HBoxContainer/LeftViewportContainer/LeftSubViewport").add_child(current_level_node)
	var splitscreen = root.get_node("Node")
	splitscreen._ready()

