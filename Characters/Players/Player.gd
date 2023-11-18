##player script that is used by player nodes to move, jump, attack, place/carry blocks, die, win and more
extends CharacterBody2D
class_name player

@onready var anim : AnimatedSprite2D = $Animation
@onready var spawn_point : Vector2 = global_position

#coyote jump mechanic
var coyotetimer : float = 0.0
var has_jumped : bool = false
@export var maxcoyotetime : float = 0.2

var direction : Vector2 = Vector2.RIGHT
var knockback : Vector2 = Vector2.ZERO
var god_mode : bool = false
##check if attack or place/carry block animation is being played
var alt_animation : bool = false
var is_attacking : bool = false

@export var speed : float = 200.0
@export var jump_vel : float = -300.0
##push force for rigid bodies
@export var push_force : float = 20.0
##player 2 place block base range
@export var base_place_range : float = 16.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

##Control resource for two player controls, resources using control.gd can be dragged to this variable in th editor
@export var controls : controls = null

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
		
	if Input.is_action_pressed(controls.up) and coyotetimer < maxcoyotetime and not has_jumped:
		velocity.y = jump_vel
		has_jumped = true
		if global_position.y > -100:
			print("jump")
		else:
			print("super jumped")

	if Input.is_action_pressed(controls.right):
		anim.flip_h = false
		direction = Vector2.RIGHT
		global_position.x += speed * delta
		if controls.player_index == 0:
			var hurtbox = $Hurtbox_Component/HurtBox
			hurtbox.position = direction * 17
			hurtbox.shape.size = Vector2(23,18)
			
			var slash = $Slash
			slash.flip_h = false
			slash.position.x = 24
		else:
			$TerrainDetector/TerrainDetectorCollsion.position.x = 9
		
	elif Input.is_action_pressed(controls.left):
		anim.flip_h = true
		direction = Vector2.LEFT
		global_position.x -= speed * delta
		if controls.player_index == 0:
			var hurtbox = $Hurtbox_Component/HurtBox
			hurtbox.position = direction * 17
			hurtbox.shape.size = Vector2(23,18)
			
			var slash = $Slash
			slash.flip_h = true
			slash.position.x = -24
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
	if Input.is_action_just_pressed("1Attack") and controls.player_index == 0 and $P1_Attack/IsAttacking.time_left == 0.1 or Input.is_action_just_pressed("2PlaceOrCarry") and controls.player_index == 1:
		alt_animation = true
	if alt_animation:
		if controls.player_index == 0:
			if direction == Vector2.DOWN:
				pass
			else:
				anim.play("attack front")
				
				var slash = $Slash
				slash.visible = true
				slash.play("slash")
				if slash.frame == 3:
					slash.visible = false
					alt_animation = false
					print("hi")
		else:
			alt_animation = false
	else:
		if velocity.y < 0:
			anim.play("jump up")
		elif velocity.y > 0:
			if controls.player_index == 0:
				anim.play("jump limit")
				while velocity.y < 0:
					anim.play("jump fall")
					break
			else:
				anim.play("jump fall")
		elif Input.is_action_pressed(controls.right) or Input.is_action_pressed(controls.left):
			anim.play("run")
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
