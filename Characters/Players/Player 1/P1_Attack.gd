extends Node

@onready var is_attacking : Timer = $IsAttacking
@onready var attack_cooldown: Timer = $Attack_Cooldown
@onready var hurtbox : Area2D = $"../Hurtbox_Component"
@export var knockback_strength_x : float = 5.0
@export var knockback_strength_y : float = 200.0
var has_knockbacked : bool = false

func _ready() -> void:
	hurtbox.monitoring = false
	
func _physics_process(_delta) -> void:
	if Input.is_action_just_pressed("1Attack") and attack_cooldown.is_stopped() and is_attacking.is_stopped(): #haha bug fixed
		get_parent().is_action = true
		hurtbox.monitoring = true
		is_attacking.start()
		

func _on_is_attacking_timeout() -> void:
	get_parent().is_action = false
	hurtbox.monitoring = false
	has_knockbacked = false
	attack_cooldown.start()

func _on_hurtbox_component_area_entered(area: Area2D) -> void:
#	print(area.get_parent().name)
	if hurtbox.monitoring and not has_knockbacked:
		if area.get_parent().name != "Player 2" :
			has_knockbacked = true
			var knockback_force = Vector2(knockback_strength_x * get_parent().direction.x * -1, -knockback_strength_y * get_parent().direction.y) 
			get_parent().knockback += knockback_force
