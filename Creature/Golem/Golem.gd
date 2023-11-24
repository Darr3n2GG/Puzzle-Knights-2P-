extends CharacterBody2D


const JUMP_VELOCITY = -400.0

@export var SPEED = 50.0
@export var group_name : String = "GolemMarker" #different golem uses different group
@onready var anim : AnimatedSprite2D = $Animation
@export var direction :int = 1
@onready var speed_value = SPEED
var positions: Array
var temp_position: Array
var next_position: Marker2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	anim.play("walk")
	
	positions = get_tree().get_nodes_in_group(group_name)
	get_positions()
	next_position = temp_position.pop_front()
	print("emeth")

func _physics_process(delta):
	if $RayCast2D.is_colliding():
		speed_value = SPEED * 3
	else:
		speed_value = SPEED
	
	
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if direction:
		velocity.x = direction * speed_value
	
	if global_position.distance_to(next_position.position) < 10:
		get_next_positions()
	
	if direction == -1:
		anim.flip_h = false
	else:
		anim.flip_h=true
	
	
	move_and_slide()

func get_positions():
	temp_position = positions.duplicate()

func get_next_positions():
	if temp_position.is_empty():
		get_positions()
	next_position = temp_position.pop_front()
	direction *= -1
	$RayCast2D.target_position.x = 50 * direction

func damaged() -> void:
	material.set_shader_parameter("flash_modifier", 1)
#	print("golem flash")
	$flash_timer.start()

func _on_flash_timer_timeout() -> void:
	material.set_shader_parameter("flash_modifier", 0)
	
func die() -> void:
	queue_free()
