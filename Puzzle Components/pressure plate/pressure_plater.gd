extends Node2D

@onready var anim = $AnimationPlayer
@onready var area = $Area_pp
@export var output_puzzle : Node2D = null


func _ready():
	area.body_entered.connect(output_puzzle._on_recieve_input)
	print("signal_connected")
	
func _on_area_pp_body_exited(_body):
	anim.play_backwards("Move")


func _on_area_pp_body_entered(_body):
	anim.play("Move")
