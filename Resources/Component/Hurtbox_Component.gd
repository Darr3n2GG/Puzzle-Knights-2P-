extends Area2D
class_name Com_HurtB

@export var damage : float = 1.0
@export var knockback_x : float = 0.0
@export var knockback_y : float = 0.0

func _on_area_entered(area: Area2D) -> void:
	print("entered")
	if area is Com_HitB:
		print("passed attack values")
		var hitbox : Com_HitB = area
		var attack_instance = Attack.new()
		attack_instance.damage = damage
		
		var knockback = Vector2(knockback_x, 0)
		if get_parent().get_class() != "AnimatableBody2D":
			
			attack_instance.knockback = knockback * Get_Direction()
		
		hitbox.damage(attack_instance, get_parent())
		
func Get_Direction(): ##direction for vector or int
	if get_parent().get("direction") == null:
		return 1
	else:
		var direction = get_parent().direction
		return direction
