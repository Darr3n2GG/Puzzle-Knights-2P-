##player script that is used by player nodes to move, jump, attack, place/carry blocks, die, win and more
extends CharacterBody2D
class_name player

##Player Animation Node (temporary)
@onready var anim : AnimatedSprite2D = $Animation
##Players spawn point when ready or respawn
@onready var spawn_point : Vector2 = global_position

##Counts the amount of sec times delta that time has passed when not on floor
var coyotetimer : float = 0.0
##Checks if player has jumped
var has_jumped : bool = false
##Max amount of time in sec that player can coyote jump when not on floor
@export var maxcoyotetime : float = 0.2

var is_pogo : bool = false

##Direction a player is facing in int value
var direction : Vector2 = Vector2.RIGHT
##knockback for player whenever being hit by something or is hitting something
var knockback : Vector2 = Vector2.ZERO
##god mode
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
	if not is_on_floor():
		velocity.y += gravity * delta
		if knockback.y <= 0:
			knockback.y += gravity * delta

	if is_on_floor():
		coyotetimer = 0.0
		has_jumped = false
	else:
		coyotetimer += delta
		
	if Input.is_action_pressed(controls.up) and coyotetimer < maxcoyotetime and not has_jumped and not is_pogo: # or Input.is_joy_button_pressed(controls.player_index,JOY_BUTTON_DPAD_UP) and is_on_floor():
		velocity.y = jump_vel
		has_jumped = true
		if global_position.y > -100:
			print("jump")
		else:
			print("super jumped")

	if Input.is_action_pressed(controls.right): #or Input.is_joy_button_pressed(controls.player_index,JOY_BUTTON_DPAD_RIGHT):
		anim.flip_h = false
		direction = Vector2.RIGHT
		global_position.x += speed * delta
		if controls.player_index == 0:
			var hurtbox = $Hurtbox_Component/HurtBox
			hurtbox.position = direction * 17
			hurtbox.shape.size = Vector2(23,18)
		else:
			$TerrainDetector/TerrainDetectorCollsion.position.x = 9
		
	elif Input.is_action_pressed(controls.left): #or Input.is_joy_button_pressed(controls.player_index,JOY_BUTTON_DPAD_LEFT):
		anim.flip_h = true
		direction = Vector2.LEFT
		global_position.x -= speed * delta
		if controls.player_index == 0:
			var hurtbox = $Hurtbox_Component/HurtBox
			hurtbox.position = direction * 17
			hurtbox.shape.size = Vector2(23,18)
		else:
			$TerrainDetector/TerrainDetectorCollsion.position.x = -9
			
	elif controls.player_index == 0:
		if Input.is_action_pressed("1Down"):
			direction = Vector2.DOWN
			var hurtbox = $Hurtbox_Component/HurtBox
			hurtbox.position = direction * 20
			hurtbox.shape.size = Vector2(18,23)
	
	if knockback != Vector2.ZERO:
		if knockback.x != 0:
			global_position.x += knockback.x
			knockback.x = lerp(knockback.x ,0.0 , 0.1)
		if knockback.y <= 0:
			velocity.y = knockback.y
		
	if global_position.y > 5000:
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
	print(get_parent(), " killed")
	global_position = spawn_point
	$HealthComponent.Set_Health()
