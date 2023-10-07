extends Node2D

@onready var anim = $AnimationPlayer
@onready var area = $Area_pp
@export var output_puzzle : Node2D = null
var pp_activated : bool = false

signal on_pp_activated(activated)

func _ready():
	self.on_pp_activated.connect(output_puzzle._on_recieve_input)
#	print("signal_connected")

func _on_area_pp_body_entered(_body):
	if area.has_overlapping_bodies() and not pp_activated:
		play_animation()
		on_pp_activated.emit(pp_activated)

func _on_area_pp_body_exited(_body):
	if not area.has_overlapping_bodies():
		play_animation()
		on_pp_activated.emit(pp_activated)

func play_animation():
	if area.has_overlapping_bodies():
		anim.play("Move")
		pp_activated = true
	else:
		anim.play_backwards("Move")
		pp_activated = false
