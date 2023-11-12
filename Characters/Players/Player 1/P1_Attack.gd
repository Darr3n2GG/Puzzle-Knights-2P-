extends Node

@onready var is_attacking : Timer = $IsAttacking
@onready var attack_cooldown: Timer = $Attack_Cooldown
@onready var hurtbox : Area2D = $"../Hurtbox_Component"
@export var knockback_strength : float = 50.0

func _ready() -> void:
	hurtbox.monitoring = false

func _physics_process(_delta) -> void:
	if Input.is_action_just_pressed("1Attack") and attack_cooldown.is_stopped(): #haha bug fixed
		hurtbox.monitoring = true
		is_attacking.start()

func _on_is_attacking_timeout() -> void:
	hurtbox.monitoring = false
	attack_cooldown.start()

func _on_hurtbox_component_area_entered(area: Area2D) -> void:
	if hurtbox.monitoring and area != player:
		var knockback_force = knockback_strength * get_parent().direction * -1
		get_parent().knockback = knockback_force
