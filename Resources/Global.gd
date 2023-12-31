extends Node

@onready var root = get_tree().root
var current_level_node = null
var current_level = 1

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("reset") and get_tree().current_scene.name != "Menu":
		reset_scene()
	if Input.is_action_just_pressed("Quit game"):
		get_tree().quit()
	

func setup_level() -> void:
	call_deferred("deferred_setup_level")
	
func deferred_setup_level() -> void:
	current_level_node = root.get_child(root.get_child_count() - 1).get_node("HBoxContainer/LeftViewportContainer/LeftSubViewport").get_child(1)
	var current_level_scene = current_level_node.scene_file_path
	current_level = current_level_scene.to_int()
	
func change_scene(path) -> void:
	level_transition()
	await get_tree().create_timer(1).timeout
	call_deferred("deferred_change_scene",path)
	
func deferred_change_scene(path) -> void:
	current_level_node.free()
	var next_scene = ResourceLoader.load(path)
	current_level_node = next_scene.instantiate()
	current_level_node.name = "Level " + str(current_level)
	if current_level_node.name != "Level 10":
		root.get_child(root.get_child_count() - 1).get_node("HBoxContainer/LeftViewportContainer/LeftSubViewport").add_child(current_level_node)
		var splitscreen = root.get_node("Node")
		splitscreen._ready()
		var fade_player : AnimationPlayer = root.get_child(root.get_child_count() - 1).get_child(root.get_child_count() + 1)
		fade_player.play_backwards("fade")
	else:
		var level_10 = preload("res://Scenes/Levels/level_10.tscn")
		level_10.change_scene()
	
func reset_scene() -> void:
	call_deferred("deferred_reset_scene")

func deferred_reset_scene():
	var current_level_file_path = current_level_node.scene_file_path
	current_level_node.free()
	current_level_node = ResourceLoader.load(current_level_file_path).instantiate()
	root.get_child(root.get_child_count() - 1).get_node("HBoxContainer/LeftViewportContainer/LeftSubViewport").add_child(current_level_node)
	var splitscreen = root.get_node("Node")
	splitscreen._ready()
	
func level_transition() -> void:
	var fade_player : AnimationPlayer = root.get_child(root.get_child_count() - 1).get_child(root.get_child_count() + 1)
	fade_player.play("fade")
	
