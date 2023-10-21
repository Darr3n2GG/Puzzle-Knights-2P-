extends RigidBody2D

@onready var p2 = get_node("../Player 2")
@onready var p1_hurtbox = get_node("../Player 1/HurtboxArea")
@export var health : float = 5.0
var p1_attackzone : bool = false
var can_damaged : bool = true

enum States
{
	carry,#being carried by player, when being spawned it will be in carry state
	placed #not being carried by player
}

var Golem_State = States.placed

func _physics_process(_delta):
	if is_instance_valid(p1_hurtbox):
		match Golem_State:
			States.placed:
				if Input.is_action_just_pressed("reset"):
					global_position = Vector2(0, -50)
				if global_position.y > 100:
					die()
				gravity_scale = 1.0
			States.carry:
				global_position = p2.global_position + Vector2(30 * p2.direction,0)
				gravity_scale = 0.0
				linear_velocity = Vector2.ZERO

func On_Create_or_Carry():
	Golem_State = States.carry
	visible = false
	disable_mode = CollisionObject2D.DISABLE_MODE_KEEP_ACTIVE
	$HealthComponent.can_damaged = false
	$Collision.disabled = true
	
func On_Placed():
	Golem_State = States.placed
	visible = true
	disable_mode = CollisionObject2D.DISABLE_MODE_REMOVE
	$HealthComponent.can_damaged = true
	$Collision.disabled = false

	
func die():
	p2.has_block = false
	queue_free()
