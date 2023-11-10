extends Area2D

#@onready var p1 = get_parent() as player
#@export var p1_attack_damage = 1
#
## Called when the node enters the scene tree for the first time.
#func _input(_event):
#	if Input.is_action_just_pressed("1Attack"): #haha bug fixed
#		Attack(p1_attack_damage)
#
###Attacks enemies with knockback 
#func Attack(attack_damage : int):
#	attack.damage = attack_damage #Easier to modify the damage
#	attack.knockback = 150 * p1.direction
#	attack.p1_attacking = true
#	$"IsAttacking".start() #Currently a place holder code
#
#func _on_is_attacking_timeout():
#	attack.p1_attacking = false
