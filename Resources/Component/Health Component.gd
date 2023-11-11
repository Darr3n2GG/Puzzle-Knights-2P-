extends Node
class_name Com_HP

@export var MaxHealth: float = 10
#@export var Name: String
#@export var type : String = "enemy" # maybe I should make naming manually
var health : float
var can_damaged: bool = true

func _ready():
	Set_Health()
	
func Set_Health():
	health = MaxHealth

func damage(attack : Attack, creature : Object) -> void: 
	var parent = get_parent()
	
	health -= attack.damage
	if parent is player:
		pass
	elif parent is Barrel:
		parent.apply_central_impulse(Vector2(attack.knockback * 200 ,0)) #knockback func
	
	var parent_class = parent.get_class()
	var creature_class = creature.get_class()
	
	print(parent_class , " is attacked by ", creature_class , ", Current health:", health)
	
	if health <= 0:
		get_parent().die()
		print(parent_class , " is killed by ", creature_class)
