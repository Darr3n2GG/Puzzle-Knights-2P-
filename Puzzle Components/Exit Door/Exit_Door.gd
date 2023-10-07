extends Node2D

@onready var door = $Shape2D2
@onready var area = $Area_Door
@onready var p1 = get_node("../Player 1")
@onready var p2 = get_node("../Player 2")
var door_activated : bool = false

signal win(index)

func _ready():
	self.win.connect(p1._on_player_win)
	self.win.connect(p2._on_player_win)

func _on_area_door_body_entered(body):
#	print("entered door ", door_activated, " ", body)
	if door_activated and body is CharacterBody2D:
		win.emit(body.controls.player_index)
#		print("emitting signal")

func _on_recieve_input(activated):
#	print(activated)
	if activated:
		door.color = Color(255,255,255)
		door_activated = true
	else:
#		print("door deactivated")
		door.color = Color(0,0,0)
		door_activated = false
