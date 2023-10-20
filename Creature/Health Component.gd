extends Node
class_name Com_HP

@export var MaxHealth = 10
var health : int


func _ready():
	health = MaxHealth

func damage(): #Bruh the code is already included
	health -= attack.damage
	if health <= 0:
		get_parent().queue_free()

