##player script that is used by player nodes to move, jump, attack, place/carry blocks, die, win and more
extends CharacterBody2D
class_name player

@onready var spawn_point : Vector2 = global_position

#coyote jump mechanic -> jump after in fall state for a certain duration in seconds
var coyotetimer : float = 0.0
var has_jumped : bool = false
@export var maxcoyotetime : float = 0.2

var direction : Vector2 = Vector2.RIGHT
var knockback : Vector2 = Vector2.ZERO
#var god_mode : bool = false
##check if attack or place/carry block animation is being played
var is_action : bool = false

@export var speed : float = 200.0
@export var jump_vel : float = -300.0
##push force for rigid bodies
@export var push_force : float = 20.0
##player 2 place block base range
@export var base_place_range : float = 16.0
##Control resource for two player controls, resources using control.gd can be dragged to this variable in th editor
@export var controls : controls = null

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var player_state : Dictionary = {
	"jump" : false,
	"fall" : false,
	"run" : false,
	"idle" : true
}

func _physics_process(delta) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
		if knockback.y <= 0:
			knockback.y += gravity * delta

	if is_on_floor():
		coyotetimer = 0.0
		has_jumped = false
		player_state["fall"] = false
	else:
		coyotetimer += delta
		
	if velocity.y > 0:
		player_state["jump"] = false
		player_state["fall"] = true
		
	if Input.is_action_pressed(controls.up) and coyotetimer < maxcoyotetime and not has_jumped:
		velocity.y = jump_vel
		has_jumped = true
		player_state["jump"] = true
		

			
	if Input.is_action_pressed(controls.right):
		direction = Vector2.RIGHT
		global_position.x += speed * delta
		player_state["run"] = true
		action_process()
		
	elif Input.is_action_pressed(controls.left):
		direction = Vector2.LEFT
		global_position.x -= speed * delta
		player_state["run"] = true
		action_process()
		
	else:
		direction.y = 0
		player_state["run"] = false
		player_state["idle"] = true
		action_process()
		
	if Input.is_action_pressed("1Down") and controls.player_index == 0:
		if player_state["jump"] or player_state["fall"]:
			direction.y = 1
			action_process()
	
	if knockback != Vector2.ZERO:
		if knockback.x != 0:
			global_position.x += knockback.x
			knockback.x = lerp(knockback.x ,0.0 , 0.1)
		if knockback.y <= 0:
			velocity.y = knockback.y
		
	if global_position.y > 5000:
		global_position = spawn_point
		
	move_and_slide()
	$Player_Animation.update_animation(direction, is_action , controls.player_index, player_state)
	push_collision()

##Adds collision to rigid bodies
func push_collision():
	for last_collided in get_slide_collision_count():
		var collided = get_slide_collision(last_collided)
		if collided.get_collider() is RigidBody2D:
			collided.get_collider().apply_central_impulse(Vector2(-collided.get_normal().x * push_force,0))
			
func action_process() -> void:
	if direction.y == 1:
		var hurtbox = $Hurtbox_Component/HurtBox
		hurtbox.position = Vector2(0,20)
		hurtbox.shape.size = Vector2(18,23)
	elif direction.x == 1:
		if controls.player_index == 0:
			var hurtbox = $Hurtbox_Component/HurtBox
			hurtbox.position = direction * 17.5
			hurtbox.shape.size = Vector2(23,18)
		else:
			$TerrainDetector/TerrainDetectorCollsion.position.x = 9
	elif direction.x == -1:
		if controls.player_index == 0:
			var hurtbox = $Hurtbox_Component/HurtBox
			hurtbox.position = direction * 17.5
			hurtbox.shape.size = Vector2(23,18)
		else:
			$TerrainDetector/TerrainDetectorCollsion.position.x = -9

func entered_door() -> void:
	visible = false
	process_mode = Node.PROCESS_MODE_DISABLED
	
func damaged() -> void:
	material.set_shader_parameter("flash_modifier", 1)
	$flash_timer.start()

func _on_flash_timer_timeout() -> void:
	material.set_shader_parameter("flash_modifier", 0)

func die():
	print(get_parent(), " killed")
	global_position = spawn_point
	$HealthComponent.Set_Health()



