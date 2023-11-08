extends Area2D
class_name Com_HB

@export var hc : Com_HP  
@onready var hurtbox = get_node("../../Player 1/HurtboxArea")
@onready var exebox = get_node("../../Door/ExecutionBox") #Problem 1: I don't know how to call the execution box

func _physics_process(_delta):
	if is_instance_valid(get_parent()):
		if hurtbox in get_overlapping_areas() and attack.p1_attacking: 
			damage()
		if exebox in get_overlapping_areas(): 
			get_parent().die()

func damage(): 
	if hc:
		hc.damage("player") 

