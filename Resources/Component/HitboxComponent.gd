extends Area2D
class_name Com_HitB

@export var hc : Com_HP  

func damage(attack : Attack, creature : Object) -> void: 
	if hc:
		hc.damage(attack, creature) 

