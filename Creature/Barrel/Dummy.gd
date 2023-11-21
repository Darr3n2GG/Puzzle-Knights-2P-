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
			global_position = p2.global_position + base_place_range * p2.direction
			gravity_scale = 0.0
			linear_velocity = Vector2.ZERO
		States.dead:
			pass

func On_Create_or_Carry() -> void:
	Golem_State = States.carry
	$Block.visible = false
	$Collision.disabled = true
	$HitboxComponent.monitorable = false
	call_deferred("set_collision_mask_value",1 , true)
	call_deferred("set_collision_mask_value",2 , true)
	call_deferred("set_collision_layer_value",2 , true)

func On_Placed() -> void :
	Golem_State = States.placed
	$Block.visible = true
	$Collision.disabled = false
	$HitboxComponent.monitorable = true
	call_deferred("set_collision_mask_value",1 , true)
	call_deferred("set_collision_mask_value",2 , true)
	call_deferred("set_collision_layer_value",2 , true)

func Setup() -> void:
	$HealthComponent.Set_Health()

func die() -> void:
	if is_instance_valid(p2):
		p2.get_node("Place_Block").block_in_scene = false 
	call_deferred("set_collision_mask_value",1 , false)
	call_deferred("set_collision_mask_value",2 , false)
	call_deferred("set_collision_layer_value",2 , false)
	$HitboxComponent.call_deferred("set_monitorable",false)
	Golem_State = States.dead
	$Block.visible = false
	$explosion.emitting = true
