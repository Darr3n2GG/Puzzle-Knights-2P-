extends CharacterBody2D

@onready var anim : Node = $Sprite2D

var coyotetimer : float = 0
var has_jumped : bool = false
const maxcoyotetime : float = 0.2
const speed : float = 200.0
const jump_vel : float = -300.0
const push_force = 40.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var controls : Resource = null

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if is_on_floor():
		coyotetimer = 0.0
		has_jumped = false
	else:
		coyotetimer += delta
	
	if Input.is_action_pressed("reset"):
		global_position = Vector2(0, -10)
	
	if Input.is_action_just_pressed(controls.up) and coyotetimer < maxcoyotetime and not has_jumped: # or Input.is_joy_button_pressed(controls.player_index,JOY_BUTTON_DPAD_UP) and is_on_floor():
		velocity.y = jump_vel
		has_jumped = true

	if Input.is_action_pressed(controls.right): #or Input.is_joy_button_pressed(controls.player_index,JOY_BUTTON_DPAD_RIGHT):
		anim.flip_h = false
		global_position.x += speed * delta
	elif Input.is_action_pressed(controls.left): #or Input.is_joy_button_pressed(controls.player_index,JOY_BUTTON_DPAD_LEFT):
		anim.flip_h = true
		global_position.x -= speed * delta
	else:
		pass
		
	if position.y > 5000:
		global_position = Vector2(0, 0)
		
	move_and_slide()
#	update_animation()
	attack(1)
	push_collision()


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

func push_collision():
	for last_collided in get_slide_collision_count():
		var collided = get_slide_collision(last_collided)
		if collided.get_collider() is RigidBody2D:
			collided.get_collider().apply_central_impulse(Vector2(-collided.get_normal().x * push_force,0))


func _input(_event):
	if Input.is_action_just_pressed("2Place"): 
		print("Wait, bro, we haven't add that.") #Place holder code for block placing function
		pass



func attack(attack_damage : int): 
	if controls.player_index == 0: #haha bug fixed
		if Input.is_action_just_pressed("1Attack"):
			global.damage = attack_damage #Easier to modify the damage
			global.p1_attacking = true
			$Timers/IsAttacking.start() #Will be changed to disable/enable the hurtbox according to animation

func _on_player_win(index):
#	print("on the way")
	if index == controls.player_index:
		queue_free()
#		print("function called")

func _on_is_attacking_timeout():
	global.p1_attacking = false
