extends RigidBody2D

class_name BarrelE
@export var cube : bool = false
var texture

func _ready():
	if cube == true:
		texture = $Block
		$Block.visible = true
		$Barrel.visible = false
	else: 
		texture = $Block
	
func Setup() -> void:
	$HealthComponent.Set_Health()

func die() -> void:
	call_deferred("set_collision_mask_value",1 , false)
	call_deferred("set_collision_mask_value",2 , false)
	call_deferred("set_collision_layer_value",2 , false)
	$HitboxComponent.call_deferred("set_monitorable",false)
	texture.visible = false
	$explosion.emitting = true
