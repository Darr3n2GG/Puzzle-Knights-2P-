extends Node
class_name Com_HP

@export var MaxHealth = 10
var health : int


func _ready():
	health = MaxHealth

func damage(Attack : attack): #Bruh I need to watch another video to know how to fix this, worst tutorial ever
	health -= attack.attack_damage
	if health <= 0:
		get_parent().queue_free()

