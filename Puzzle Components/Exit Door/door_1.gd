extends Node2D
@onready var door = $Shape2D2
var activated : bool = false


#func _ready():
#	connect("Test", triggered)
#func triggered():
#	door.color = Color(255,255,255)


func _on_area_door_body_entered(_body):
	if activated == false:
		print("bad")
	else:
		print("good")

func _on_recieve_input(_recieved):
	door.color = Color(255,255,255)
	activated = true
