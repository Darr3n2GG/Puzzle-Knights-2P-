extends RigidBody2D

class_name Barrel

@onready var p2 = get_node("../Player 2") as player

enum States
{
	carry,#being carried by player, when being spawned it will be in carry state
	placed, #not being carried by player
	dead #is dead
}
var Golem_State = States.placed

var p1_attackzone : bool = false
var can_damaged : bool = true
@export var base_place_range : float = 16.0

func _physics_process(_delta) -> void:
	match Golem_State:
		States.placed:
			if Input.is_action_just_pressed("reset"):
				global_position = Vector2(0, -50)
			if global_position.y > 100:
				die()
			gravity_scale = 1.0
		States.carry:
			global_position = p2.global_position + Vector2(base_place_range * p2.direction,0)
			gravity_scale = 0.0
			linear_velocity = Vector2.ZERO
		States.dead:
			pass

func On_Create_or_Carry() -> void:
	Golem_State = States.carry
	visible = false
	$Collision.disabled = true
	$HitboxComponent.monitorable = false

func On_Placed() -> void :
	Golem_State = States.placed
	visible = true
	$Collision.disabled = false
	$HitboxComponent.monitorable = true

func Setup() -> void:
	$HealthComponent.Set_Health()

func die() -> void:
	if is_instance_valid(p2):
		p2.get_node("Place_Block").block_in_scene = false 
	$Collision.call_deferred("set_disabled",true)
	Golem_State = States.dead
	visible = false
