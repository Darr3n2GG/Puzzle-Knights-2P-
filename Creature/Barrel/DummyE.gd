extends RigidBody2D

class_name BarrelE

func Setup() -> void:
	$HealthComponent.Set_Health()

func die() -> void:
	call_deferred("set_collision_mask_value",1 , false)
	call_deferred("set_collision_mask_value",2 , false)
	call_deferred("set_collision_layer_value",2 , false)
	$HitboxComponent.call_deferred("set_monitorable",false)
	$Block.visible = false
	$explosion.emitting = true
