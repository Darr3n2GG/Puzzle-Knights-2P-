##CharacterBody2d script that is used by player nodes to move, jump, attack, place/carry blocks, die, win and more
class_name player
extends CharacterBody2D

##Player Animation Node (temporary)
@onready var anim : AnimatedSprite2D = $animation
##Players spawn point when ready or respawn
@onready var spawn_point : Vector2 = global_position

##Counts the amount of sec times delta that time has passed when not on floor
var coyotetimer : float = 0.0
##Checks if player has jumped
var has_jumped : bool = false
##Max amount of time in sec that player can coyote jump when not on floor
@export var maxcoyotetime : float = 0.2

##Direction a player is facing in int value
var direction : int = 1

var god_mode : bool = false

##Speed value of player
@export var speed : float = 200.0
##Jump velocity value of player
@export var jump_vel : float = -300.0
##Amount of push force player can exert on rigid bodies
@export var push_force : float = 20.0
##Place range of player
@export var base_place_range : float = 16.0

##Gravity from project settings
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

##Control resource for two player controls, resources using control.gd can be dragged to this variable in th editor
@export var controls : Resource = null

func _physics_process(delta) -> void:
	if not is_on_floor() and not god_mode:
		velocity.y += gravity * delta

	if is_on_floor() and not god_mode:
		coyotetimer = 0.0
		has_jumped = false
	else:
		coyotetimer += delta
	if not god_mode:
		if Input.is_action_pressed(controls.up) and coyotetimer < maxcoyotetime and not has_jumped: # or Input.is_joy_button_pressed(controls.player_index,JOY_BUTTON_DPAD_UP) and is_on_floor():
			velocity.y = jump_vel
			has_jumped = true
	else:
		if Input.is_action_pressed(controls.up):
			global_position.y += jump_vel * delta

	if Input.is_action_pressed(controls.right): #or Input.is_joy_button_pressed(controls.player_index,JOY_BUTTON_DPAD_RIGHT):
		anim.flip_h = false
		direction = 1
		global_position.x += speed * delta
		if controls.player_index == 0:
			$Hurtbox_Component/HurtBox.position.x = 17
		else:
			$TerrainDetector/TerrainDetectorCollsion.position.x = 9
				
		
	elif Input.is_action_pressed(controls.left): #or Input.is_joy_button_pressed(controls.player_index,JOY_BUTTON_DPAD_LEFT):
		anim.flip_h = true
		direction = -1
		global_position.x -= speed * delta
		if controls.player_index == 0:
			$Hurtbox_Component/HurtBox.position.x = -17
		else:
			$TerrainDetector/TerrainDetectorCollsion.position.x = -9
			
	elif Input.is_action_just_pressed("god_mode"):
		if god_mode:
			god_mode = false
		else:
			god_mode = true
	else:
		pass
		
	if position.y > 5000:
		global_position = spawn_point
		
	move_and_slide()
	update_animation()
	push_collision()

func update_animation():
	if controls.player_index == 1:
		if velocity.y < 0:
			while not is_on_floor():
				anim.play("jump up")
				if anim.frame == 2:
					anim.pause()
				break
		elif velocity.y > 0:
			while not is_on_floor():
				anim.play("jump fall")
				if anim.frame == 1:
					anim.pause()
				break
		elif Input.is_action_pressed("2Right") or Input.is_action_pressed("2Left"):
			anim.play("move")
		else:
			anim.play("idle")

##Adds collision to rigid bodies
func push_collision():
	for last_collided in get_slide_collision_count():
		var collided = get_slide_collision(last_collided)
		if collided.get_collider() is RigidBody2D:
			collided.get_collider().apply_central_impulse(Vector2(-collided.get_normal().x * push_force,0))

func entered_door() -> void:
	visible = false
	process_mode = Node.PROCESS_MODE_DISABLED

func die():
	print("Assume player is killed")
	global_position = spawn_point
