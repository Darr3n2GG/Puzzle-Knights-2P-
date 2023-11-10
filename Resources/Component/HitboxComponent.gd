extends Area2D
class_name Com_HitB

@export var hc : Com_HP  
#@onready var hurtbox = get_node("../../Player 1/HurtboxArea")
#@onready var exebox = get_node("../../Door/ExecutionBox") #Problem 1: I don't know how to call the execution box

#func _physics_process(_delta):
#	if hurtbox in get_overlapping_areas() and attack.p1_attacking: 
#		damage()
#	if exebox in get_overlapping_areas(): 
#		get_parent().die()

func damage(attack : Attack, creature : Object) -> void: 
	if hc:
		hc.damage(attack, creature) 

