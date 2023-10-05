extends Node2D

@onready var anim = $AnimationPlayer
@onready var area = $Area_pp
@export var output_puzzle : Node2D = null
var pp_activated : bool = false


func _ready():
	area.body_entered.connect(output_puzzle._on_recieve_input)
	area.body_exited.connect(output_puzzle._on_recieve_input)
#	print("signal_connected")
	
func _on_area_pp_body_exited(_body):
	if area.has_overlapping_bodies() == false:
		play_animation()

func _on_area_pp_body_entered(_body):
	if area.has_overlapping_bodies() == true and pp_activated == false:
		play_animation()
	
#
#func _process(_delta):
#	if area.has_overlapping_bodies() == true:
#		pp_activated = true
#	else:
#		pp_activated = false
		

func play_animation():
	if area.has_overlapping_bodies() == true:
		anim.play("Move")
		pp_activated = true
	else:
		anim.play_backwards("Move")
		pp_activated = false
