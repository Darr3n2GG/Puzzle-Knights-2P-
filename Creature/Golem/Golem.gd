extends CharacterBody2D

const SPEED = 50.0
const JUMP_VELOCITY = -400.0

@onready var anim : AnimatedSprite2D = $Animation
@export var group_name: String
@export var direction :int = 1
var positions: Array
var temp_position: Array
var next_position: Marker2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	anim.play("walk_left")
	
	positions = get_tree().get_nodes_in_group(group_name)
	get_positions()
	next_position = temp_position.pop_front()
	print("emeth")

func _physics_process(delta):
	
	
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if direction:
		velocity.x = direction * SPEED
	
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



