extends RigidBody2D

var health = 10
var p1_attackzone = false


func _physics_process(_delta):
	damaged()
	
	if Input.is_action_just_pressed("reset"):
		global_position = Vector2(0, -50)



func _on_hitbox_body_entered(body):
	if body.has_method("player_1"):
		p1_attackzone = true


func _on_hitbox_body_exited(body):
	if body.has_method("player_1"):
		p1_attackzone = false

func damaged():
	if p1_attackzone and global.p1_attacking:
		health = health - global.damage
		print("Stop vandalism! Barrel health:", health)
		if health <= 0:
			self.queue_free()
			print("I said STOP!!! You have broken the barrel!")
