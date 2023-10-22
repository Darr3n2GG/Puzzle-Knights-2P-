extends Node2D

@onready var animation_player = $AnimationPlayer

func _on_recieve_input(activated):
	if activated:
		animation_player.play("move")
	else:
		animation_player.play_backwards("move")
