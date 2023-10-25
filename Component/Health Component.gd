extends Node
class_name Com_HP

@export var MaxHealth: float = 10
@export var Name: String
var type: String
var health : float
var can_damaged: bool = true

func _ready():
	health = MaxHealth
	if Name == "Player 1" or Name == "Player 2":
		type = "Pl"
	elif Name == "Dummy":
		type == Name
	else:
		type == "En"
	

func damage(agent: String): 
	if can_damaged:
		if type != "Pl":
			get_parent().apply_central_impulse(Vector2(attack.knockback,0)) #knockback func
		if type != agent: #No suiciding
			health -= attack.damage #damaged func
			$Damaged_CD.start() 
			can_damaged = false
			print(Name, " health: ", health)
		if health <= 0:
			get_parent().die()
			get_parent().queue_free()
			print(Name, " is killed")

func _on_damaged_cd_timeout():
	can_damaged = true
