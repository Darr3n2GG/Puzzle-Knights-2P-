extends Node2D

@onready var output_class = Output_Puzzle.new()
@export var move_direction : float = 1.0
@export var offset = Vector2(0, 0)
@export var duration : float = 0.0
@export var killable : bool = true

func _ready() -> void:
	if not killable:
		$AnimatableBody2D/Hurtbox_Component.monitoring = false
		$AnimatableBody2D/noDMG_collision.disabled = false

func _on_recieve_input(is_activated : bool) -> void:
	output_class.activated = is_activated
	var play_anim : bool = output_class.Check_Activation()
	if play_anim:
		var move_direction_vector : Vector2 = Vector2(move_direction, move_direction)
		var final_offset : Vector2 = offset * move_direction_vector
#		var move_amount : float = 10 * move_direction
		if is_activated:
			start_tween(final_offset)
		else:
			start_tween(Vector2.ZERO)
			
func start_tween(stated_offset : Vector2) -> void:
	call_deferred("deferred_start_tween",stated_offset)
	
func deferred_start_tween(stated_offset : Vector2) -> void:
	var tween = get_tree().create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	tween.set_loops().set_parallel(false)
	tween.tween_property($AnimatableBody2D, "position", stated_offset, duration / 2)
	tween.bind_node(self)
