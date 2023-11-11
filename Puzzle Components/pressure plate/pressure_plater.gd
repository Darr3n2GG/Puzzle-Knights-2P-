extends Node2D

@onready var anim = $AnimationPlayer
@onready var area = $Area_2D
@onready var input_class = Input_Puzzle.new()
@export var puzzle_array : Array[Node2D]

func _ready():
	input_class.output_puzzles = puzzle_array
#	print(input_class.output_puzzles)
	input_class.setup()

func _on_area_pp_body_entered(_body):
	if area.has_overlapping_bodies() and not input_class.activated:
		anim.play("Move")
		input_class.send_input(true)

func _on_area_pp_body_exited(_body):
	if not area.has_overlapping_bodies():
		anim.play_backwards("Move")
		input_class.send_input(false)
