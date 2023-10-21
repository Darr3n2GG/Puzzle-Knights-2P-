extends Node
class_name Com_HP

@export var MaxHealth = 10
var health : int
var can_damaged: bool = true

func _ready():
	health = MaxHealth

func damage(): 
	if can_damaged:
		health -= global.damage #damaged func
		get_parent().global_position.x += global.knockback #knockback func
		$Damaged_CD.start()
		can_damaged = false
		print("Health: ", health)
		if health <= 0:
			get_parent().queue_free()
			print("Entity killed")



func _on_damaged_cd_timeout():
	can_damaged = true
