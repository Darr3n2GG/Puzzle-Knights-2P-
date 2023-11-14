extends Area2D
class_name Com_HitB

@export var hc : Com_HP  

func damage(attack : Attack, creature : Object) -> void: 
	if hc and get_parent() != player:
		hc.damage(attack, creature) 

