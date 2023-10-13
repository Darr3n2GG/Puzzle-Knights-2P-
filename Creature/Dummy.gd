extends RigidBody2D

@onready var hurtbox = get_node("../Player 1/HurtboxArea")
var health : float = 5.0
var p1_attackzone : bool = false
var can_damaged : bool = true


func _physics_process(_delta):
	if (weakref(self).get_ref()):
		if Input.is_action_just_pressed("reset"):
			global_position = Vector2(0, -50)
		if hurtbox in $Area2D.get_overlapping_areas():
			p1_attackzone = true
		else: 
			p1_attackzone = false
		damaged()

func damaged():
	if p1_attackzone and global.p1_attacking:
		if can_damaged:
			health -= global.damage
			global_position.x += global.knockback
			$Damaged_CD.start()
			can_damaged = false
			print("Stop vandalism! Barrel health: ", health)
			if health <= 0:
				self.queue_free()
				print("I said STOP!!! What have you done?!")


func _on_damaged_cd_timeout():
	can_damaged = true 
