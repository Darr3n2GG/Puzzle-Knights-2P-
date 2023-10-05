extends Node2D

@onready var door = $Shape2D2
@onready var area = $Area_Door
var door_activated : bool = false

signal win(index)


func _on_area_door_body_entered(body):
#	print("entered door ", door_activated, " ", body)
	if door_activated == true and body is CharacterBody2D:
		win.emit(body.controls.player_index)
#		print("emitting signal")

func _on_recieve_input(_recieved):
	if door_activated == false:
		door.color = Color(255,255,255)
		door_activated = true
	else:
#		print("door deactivated")
		door.color = Color(0,0,0)
		door_activated = false
