extends Node2D

var door_activated : bool = false
##How many players have exited
var players_exited : int = 0
const FILE_BEGIN = "res://Scenes/Levels/level_"

func _on_area_door_body_entered(body):
#	print("entered door ", door_activated, " ", body)
	if door_activated and body is CharacterBody2D:
		body.queue_free()
		players_exited += 1
		if players_exited == 2:
			var current_scene_file = get_parent().scene_file_path
			var next_level_number = current_scene_file.to_int() + 1
			var next_level_path = FILE_BEGIN + str(next_level_number) + ".tscn"
			global.change_scene(next_level_path)
			

func _on_recieve_input(activated):
	var door = $Door
#	print(activated)
	if activated:
		door.visible = false
		door_activated = true
	else:
#		print("door deactivated")
		door.visible = true
		door_activated = false
