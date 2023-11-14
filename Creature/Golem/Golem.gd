extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var group_name: String
var positions: Array
var temp_position: Array
var current_position: Marker2D
var direction :int = 1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	positions = get_tree().get_nodes_in_group(group_name)
	get_positions()
	get_next_positions()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
	
	if global_position.distance_to(current_position.position) < 10:
		get_next_positions()

func get_positions():
	temp_position = positions.duplicate()

func get_next_positions():
	if temp_position.is_empty():
		get_positions()
	current_position = temp_position.pop_front()
	direction *= -1




