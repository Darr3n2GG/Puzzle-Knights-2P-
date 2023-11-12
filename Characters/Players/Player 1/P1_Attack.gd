extends Node

@onready var timer : Timer = $IsAttacking
@onready var hurtbox : Area2D = $"../Hurtbox_Component"
var has_hit : bool = false
@export var knockback_strength : float = 50.0

func _ready() -> void:
	hurtbox.monitoring = false

func _physics_process(_delta) -> void:
	if Input.is_action_just_pressed("1Attack"): #haha bug fixed
		hurtbox.monitoring = true
		timer.start()

func _on_is_attacking_timeout() -> void:
	has_hit = false
	hurtbox.monitoring = false

func _on_hurtbox_component_area_entered(_area: Area2D) -> void:
	if hurtbox.monitoring:
		var knockback_force = knockback_strength * get_parent().direction * -1
		get_parent().knockback = knockback_force
