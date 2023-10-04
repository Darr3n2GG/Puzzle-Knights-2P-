extends Node2D

@onready var line = $Line2D
@onready var ray = $RayCast2D
@export var target_pos = Vector2(0,0)

func _physics_process(_delta):
	line.clear_points()
	line.add_point(Vector2.ZERO)
	ray.target_position = target_pos
	if ray.is_colliding():
		line.add_point(to_local(ray.get_collision_point()))
#		print(ray.get_collider())
		if ray.get_collider() == get_node("../Player/HitBox_Component"):
			var hitbox = get_node("../Player/HitBox_Component")
#			var attack = Attack.new()
#			attack.attack_damage = 1.0
#			hitbox.damage(attack)
#			print("SUCCESS")
