extends Area2D
class_name Com_HurtB

@export var damage : float = 1.0
@export var knockback_x : float = 0.0
@export var knockback_y : float = 0.0
@export var hurtbox_cooldown : float = 1.0
@export var oneshot : bool = false
var hitbox : Com_HitB

func _ready() -> void:
	$Hurtbox_Timer.wait_time = hurtbox_cooldown

func _on_area_entered(area: Area2D) -> void:
#	print("entered")
	if area is Com_HitB:
		hitbox = area
		damage_area()
		if not oneshot:
			$Hurtbox_Timer.start()
#
func damage_area() -> void:
#		print("passed attack values")
	var attack_instance = Attack.new()
	attack_instance.damage = damage

	var knockback = Vector2(knockback_x, 0)
	if get_parent().get_class() != "AnimatableBody2D":

		attack_instance.knockback = knockback * Get_Direction()

	hitbox.damage(attack_instance, get_parent())
	
func _on_area_exited(_area: Area2D) -> void:
	$Hurtbox_Timer.stop()

func Get_Direction(): ##direction for vector or int
	if get_parent().get("direction") == null:
		return 1
	else:
		var direction = get_parent().direction
		return direction

func _on_hurtbox_timer_timeout() -> void:
	damage_area()



