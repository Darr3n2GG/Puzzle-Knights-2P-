extends Node2D
@onready var door = $Shape2D2
@onready var text = get_parent().get_node("HUD/Control/Label") 


#func _ready():
#	connect("Test", triggered)
#func triggered():
#	door.color = Color(255,255,255)


func _on_area_door_body_entered(_body):
	text.visible = true

func _on_test_new(code):
	print("code ", code, " recieved")
	if (code == 1):
		door.color = Color(255,255,255)
