extends Node
class_name Com_HP

@export var MaxHealth: float = 10
@export var Name: String
var health : float
var can_damaged: bool = true

func _ready():
	health = MaxHealth

func damage(): 
	if can_damaged:
		health -= attack.damage #damaged func
		get_parent().apply_central_impulse(Vector2(attack.knockback,0)) #knockback func
		$Damaged_CD.start()
		can_damaged = false
		print(Name, " health: ", health)
		if health <= 0:
			get_parent().die()
			get_parent().queue_free()
			print(Name, " is killed")



func _on_damaged_cd_timeout():
	can_damaged = true
