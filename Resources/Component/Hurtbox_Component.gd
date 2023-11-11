extends Area2D
class_name Com_HurtB

@export var damage : float = 1.0
@export var knockback : float = 0.0

func _on_area_entered(area: Area2D) -> void:
	print("entered")
	if area is Com_HitB:
		print("passed attack values")
		var hitbox : Com_HitB = area
		var attack_instance = Attack.new()
		attack_instance.damage = damage
		attack_instance.knockback = knockback * get_parent().direction
		
		hitbox.damage(attack_instance, get_parent())
