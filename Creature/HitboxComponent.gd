#I might not need this component as we already have a hurtbox code

extends Area2D
class_name Com_HB

@export var hc : Com_HP  



func damage(): 
	if hc:
		hc.damage()

