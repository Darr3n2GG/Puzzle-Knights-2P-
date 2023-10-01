extends RigidBody2D

func _physics_process(delta):
	if Input.is_action_just_pressed("reset"):
		global_position = Vector2(0, -10)
