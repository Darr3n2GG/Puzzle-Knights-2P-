extends Area2D

@export var hc : Com_HP  #I declared but could not find it?



func damage(attack:Attack): #Same thing again
	if hc:
		hc.damage(attack)

