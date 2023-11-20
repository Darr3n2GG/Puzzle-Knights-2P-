extends RigidBody2D

class_name BarrelE

enum States
{
	dead #is dead
}

var p1_attackzone : bool = false
var can_damaged : bool = true
@export var base_place_range : float = 16.0

func Setup() -> void:
	$HealthComponent.Set_Health()
	
func damaged() -> void:
	$explosion.emitting = true

func die() -> void:
	$Collision.call_deferred("set_disabled",true)
	visible = false
