extends StaticBody2D

class_name bounceshroom

func _on_com_hit_b_damaged() -> void:
	$explosion.restart()
	await get_tree().create_timer(1.0).timeout

