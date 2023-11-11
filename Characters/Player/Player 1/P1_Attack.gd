extends Node

@onready var timer : Timer = $IsAttacking
@onready var hurtbox : Area2D = $"../Hurtbox_Component"

func _ready() -> void:
	hurtbox.monitoring = false

func _physics_process(_delta) -> void:
	if Input.is_action_just_pressed("1Attack"): #haha bug fixed
		hurtbox.monitoring = true
		timer.start()

func _on_is_attacking_timeout() -> void:
	hurtbox.monitoring = false
