extends Node2D

@onready var door = $Shape2D2
@onready var area = $Area_Door
var activated : bool = false

signal win(index)


func _on_area_door_body_entered(body):
	print("entered door ", activated, " ", body)
	if activated == true and body is CharacterBody2D:
		win.emit(body.controls.player_index)
		print("emitting signal")

func _on_recieve_input(_recieved):
	door.color = Color(255,255,255)
	activated = true
