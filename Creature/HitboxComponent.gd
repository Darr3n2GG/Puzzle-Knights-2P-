extends Area2D

@export var hc : Com_HP  



func damage(): #Same thing again
	if hc:
		hc.damage()

