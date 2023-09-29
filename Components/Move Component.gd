extends CharacterBody2D

@onready var anim : Node = $Sprite2D
const speed : float = 200.0
const jump_vel : float = -300.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")



func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_pressed("reset"):
		global_position = Vector2(0, -10)
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_vel

	if Input.is_action_pressed("right"):
		anim.flip_h = false
		global_position.x += speed * delta
	elif Input.is_action_pressed("left"):
		anim.flip_h = true
		global_position.x -= speed * delta
	else:
		pass
		
	if position.y > 5000:
		global_position = Vector2(0, 0)
		
	move_and_slide()
#	update_animation()
#
#
#func update_animation():
#	if velocity.y < 0:
#		while not is_on_floor():
#			anim.play("jump_start")
#			if anim.frame == 1:
#				anim.pause()
#			break
#	elif velocity.y > 0:
#		while not is_on_floor():
#			anim.play("jump_finish")
#			break
#	elif Input.is_action_pressed("right") or Input.is_action_pressed("left"):
#		anim.play("run")
#	else:
#		anim.play("idle")



