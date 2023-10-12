extends RigidBody2D

@onready var hurtbox = get_node("../Player 1/Area2D")
var health = 5
var p1_attackzone = false
var can_damaged = true


func _physics_process(_delta):
	if Input.is_action_just_pressed("reset"):
		global_position = Vector2(0, -50)
	damaged()



func _on_hitbox_body_entered(body):
	if body.get_child(2) == hurtbox:
		p1_attackzone = true
#		print("Get away from that barrel!")


func _on_hitbox_body_exited(body):
	if body == hurtbox:
		p1_attackzone = false

func damaged():
	if p1_attackzone and global.p1_attacking:
		if can_damaged:
			health = health - global.damage
			$Damaged_CD.start()
			can_damaged = false
			print("Stop vandalism! Barrel health: ", health)
			if health <= 0:
				self.queue_free()
				print("I said STOP!!! What have you done?!")


func _on_damaged_cd_timeout():
	can_damaged = true 
