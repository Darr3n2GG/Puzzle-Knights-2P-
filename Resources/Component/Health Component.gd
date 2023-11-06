extends Node
class_name Com_HP

@export var MaxHealth: float = 10
@export var Name: String
@export var type : String = "enemy" # maybe I should make naming manually
var health : float
var can_damaged: bool = true

func _ready():
	Set_Health()
	
func Set_Health():
	health = MaxHealth
	

func damage(agent: String): 
	if can_damaged:
		if type == "dummy":
			get_parent().apply_central_impulse(Vector2(attack.knockback,0)) #knockback func
		if type != agent: #No suiciding
			health -= attack.damage #damaged func
			$Damaged_CD.start() 
			can_damaged = false
			print(Name, " is attacked by ", agent, ", Current health:", health)
		if health <= 0:
			get_parent().die()
			print(Name, " is killed by", agent)

func _on_damaged_cd_timeout():
	can_damaged = true
