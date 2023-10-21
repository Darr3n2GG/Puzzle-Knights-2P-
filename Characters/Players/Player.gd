##CharacterBody2d script that is used by player nodes to move, jump, attack, place/carry blocks, die, win and more
extends CharacterBody2D

##Player Animation Node (temporary)
@onready var anim : AnimatedSprite2D = $animation

var placed_block : RigidBody2D
##Counts the amount of sec times delta that time has passed when not on floor
var coyotetimer : float = 0.0
##Checks if player has jumped
var has_jumped : bool = false
##Direction a player is facing in int value
var direction : int = 1

var dist : float

enum states
{
	carry,
	placed
}

var p2_states = states.placed

var has_block : bool = false
##Max amount of time in sec that player can coyote jump when not on floor
const maxcoyotetime : float = 0.2
##Speed value of player
const speed : float = 200.0
##Jump velocity value of player
const jump_vel : float = -300.0
##Amount of push force player can exert on rigid bodies
const push_force : float = 40.0

##Gravity from project settings
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

##Control resource for two player controls, resources using control.gd can be dragged to this variable in th editor
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
		direction = 1
		global_position.x += speed * delta
		if controls.player_index == 0:
			$HurtboxArea/HurtBox.position.x = 17
	elif Input.is_action_pressed(controls.left): #or Input.is_joy_button_pressed(controls.player_index,JOY_BUTTON_DPAD_LEFT):
		anim.flip_h = true
		direction = -1
		global_position.x -= speed * delta
		if controls.player_index == 0:
			$HurtboxArea/HurtBox.position.x = -17
	else:
		pass
		
	if controls.player_index == 0 and Input.is_action_just_pressed("1Attack"): #haha bug fixed
		Attack(1)
		
	if position.y > 5000:
		global_position = Vector2(0, 0)
		
	move_and_slide()
	update_animation()
	push_collision()

func update_animation():
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
	if controls.player_index == 1:
		anim.play("idle")

##Adds collision to rigid bodies
func push_collision():
	for last_collided in get_slide_collision_count():
		var collided = get_slide_collision(last_collided)
		if collided.get_collider() is RigidBody2D:
			collided.get_collider().apply_central_impulse(Vector2(-collided.get_normal().x * push_force,0))

func _input(_event):
	if controls.player_index == 1:
		if Input.is_action_just_pressed("2PlaceOrCarry"):# and not placed_block: 
			if has_block == false:
				Create_Block()
			else:
				if is_instance_valid(placed_block):
					match p2_states:
						states.placed:
							dist = global_position.distance_to(placed_block.global_position)
							if dist < 100:
								Carry_Block()
								p2_states = states.carry
						states.carry:
							Place_Block()
							p2_states = states.placed

##Places a block with carry state
func Create_Block(): 
	var block = load("res://Creature/Dummy.tscn")
	placed_block = block.instantiate()
	placed_block.set_name("block")
	placed_block.global_position.x = global_position.x + 25 * direction
	get_owner().add_child(placed_block)
	Carry_Block()
	p2_states = states.carry
	has_block = true
	
func Place_Block():
	$Block.visible = false
	$Carry_State_Collision.disabled = true
	placed_block.On_Placed()
	
func Carry_Block():
	$Block.visible = true
	$Carry_State_Collision.disabled = false
	placed_block.On_Create_or_Carry()

##Attacks enemies with knockback
func Attack(attack_damage : int):
	attack.damage = attack_damage #Easier to modify the damage
	attack.knockback = 150 * direction
	attack.p1_attacking = true
	$Timers/IsAttacking.start() #Currently a place holder code

func _on_is_attacking_timeout():
	attack.p1_attacking = false

func _on_player_win(index):
#	print("on the way")
	if index == controls.player_index:
		queue_free()
#		print("function called")

