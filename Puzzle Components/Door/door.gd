extends Node2D

@onready var animation_player = $AnimationPlayer
@onready var output_class = Output_Puzzle.new()
@export var move_direction : int = 1

func _on_recieve_input(is_activated : bool) -> void:
	output_class.activated = is_activated
	var play_anim : bool = output_class.Check_Activation()
	if play_anim:
		if is_activated:
			global_position.y -= 100 * move_direction
		else:
			global_position.y += 100 * move_direction
