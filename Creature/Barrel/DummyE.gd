extends RigidBody2D

class_name BarrelE

@onready var p2 = get_node("../Player 2") as player

enum States
{
	dead #is dead
}

var p1_attackzone : bool = false
var can_damaged : bool = true
@export var base_place_range : float = 16.0

func Setup() -> void:
	$HealthComponent.Set_Health()

func die() -> void:
	if is_instance_valid(p2):
		p2.get_node("Place_Block").block_in_scene = false 
	$Collision.call_deferred("set_disabled",true)
	visible = false
