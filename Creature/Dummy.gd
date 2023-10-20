extends RigidBody2D

@onready var player = get_node("../Player 2")
@onready var hurtbox = get_node("../Player 1/HurtboxArea")
@export var health : float = 5.0
var p1_attackzone : bool = false
var can_damaged : bool = true

enum States
{
	carry,#being carried by player, when being spawned it will be in carry state
	placed #not being carried by player
}

var Golem_State = States.placed

func _physics_process(_delta):
	match Golem_State:
		States.placed:
			if Input.is_action_just_pressed("reset"):
				global_position = Vector2(0, -50)
			if global_position.y > 100:
				queue_free()
			if is_instance_valid(hurtbox):
				if hurtbox in $Area2D.get_overlapping_areas():
					p1_attackzone = true
				else: 
					p1_attackzone = false
				damaged()
		
		States.carry:
			visible = false
			disable_mode = CollisionObject2D.DISABLE_MODE_KEEP_ACTIVE
			$Area2D.DISABLE_MODE_KEEP_ACTIVE

func On_Placed():
	Golem_State = States.carry

func damaged():
	if p1_attackzone and attack.p1_attacking:
		if can_damaged:
			health -= attack.damage
			apply_central_impulse(Vector2(attack.knockback,0))
			$Damaged_CD.start()
			can_damaged = false
			print("Stop vandalism! Barrel health: ", health)
			if health <= 0:
				queue_free()
				print("I said STOP!!! What have you done?!")

func _on_damaged_cd_timeout():
	can_damaged = true 
