extends Node2D

@onready var anim = $AnimationPlayer
@export var input_area : Area2D = null
@export var output_puzzle : Node2D = null


func _ready():
	input_area.body_entered.connect(output_puzzle._on_recieve_input)
	input_area.body_entered.connect(input_area.get_parent()._on_recieve_input)

func _on_recieve_input(_recieved):
	anim.play("Move")
	
func _on_area_pp_body_exited(_body):
	anim.play_backwards("Move")
