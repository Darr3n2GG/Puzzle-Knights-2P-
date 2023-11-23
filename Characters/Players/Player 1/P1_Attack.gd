extends Node

@onready var is_attacking : Timer = $IsAttacking
@onready var attack_cooldown: Timer = $Attack_Cooldown
@onready var hurtbox : Area2D = $"../Hurtbox_Component"
@onready var parent = get_parent() as player
@export var knockback_strength_x : float = 5.0
@export var knockback_strength_y : float = 200.0
@export var attack_knockback_x : float = 4
@export var attack_knockback_y : float = -100
var has_knockbacked : bool = false

func _ready() -> void:
	hurtbox.monitoring = false
	
func _physics_process(_delta) -> void:
	if Input.is_action_just_pressed("1Attack") and attack_cooldown.is_stopped() and is_attacking.is_stopped(): 
		attack()
		
	if Input.is_action_just_pressed("1Slash") and parent.direction.y == 1 and attack_cooldown.is_stopped() and is_attacking.is_stopped(): 
		attack()

func attack() -> void:
	parent.is_action = true
	hurtbox.monitoring = true
	is_attacking.start()
	if parent.direction.y == 1:
		$"../Hurtbox_Component".knockback_y = attack_knockback_y
		$"../Hurtbox_Component".knockback_x = 0
	else: 
		$"../Hurtbox_Component".knockback_y = 0
		$"../Hurtbox_Component".knockback_x = attack_knockback_x


func _on_is_attacking_timeout() -> void:
	parent.is_action = false
	hurtbox.monitoring = false
	has_knockbacked = false
	attack_cooldown.start()

func _on_hurtbox_component_area_entered(area: Area2D) -> void:
#	print(area.get_parent().name)
	if hurtbox.monitoring and not has_knockbacked:
		if area.get_parent().name != "Player 2" :
			has_knockbacked = true
			var knockback_force = calculate_force()
			parent.knockback += knockback_force
			
func calculate_force() -> Vector2:
	if parent.direction.y == 1:
		return Vector2(0,-knockback_strength_y * get_parent().direction.y)
	else:
		return Vector2(knockback_strength_x * get_parent().direction.x * -1,0)
