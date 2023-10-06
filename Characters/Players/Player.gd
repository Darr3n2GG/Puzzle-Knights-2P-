extends CharacterBody2D

@onready var anim : Node = $Sprite2D

const speed : float = 200.0
const jump_vel : float = -300.0
const push_force = 40.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var controls : Resource = null




func _physics_process(delta):
	attack()
	
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_pressed("reset"):
		global_position = Vector2(0, -10)
	
	if Input.is_action_just_pressed(controls.up) and is_on_floor():
		velocity.y = jump_vel

	if Input.is_action_pressed(controls.right):
		anim.flip_h = false
		global_position.x += speed * delta
	elif Input.is_action_pressed(controls.left):
		anim.flip_h = true
		global_position.x -= speed * delta
	else:
		pass
		
	if position.y > 5000:
		global_position = Vector2(0, 0)
		
	move_and_slide()
#	update_animation()
	for last_collided in get_slide_collision_count():
		var collided = get_slide_collision(last_collided)
		if collided.get_collider() is RigidBody2D:
			collided.get_collider().apply_central_impulse(Vector2(-collided.get_normal().x * push_force,0))


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


func _input(_event):
	if Input.is_action_just_pressed("2Place"): 
		print("Wait, bro, we haven't add that.") #Place holder code for block placing function
		pass



func attack(): 
	if controls.player_index == 0: #haha bug fixed
		if Input.is_action_just_pressed("1Attack"):
			print("Bro is trying to attack")
			global.p1_attacking = true
			$Attacking.start(-1) #Timer is only available on P1

func _on_attacking_timeout():
	$Attacking.stop()
	global.p1_attacking = false



func _on_exit_door_win(index):
#	print("on the way")
	if index == controls.player_index:
		queue_free()
#		print("function called")


func _on_area_2d_area_entered(area):
	pass # Replace with function body.
