extends Node

class_name Input_Puzzle

var output_puzzles : Array[Node2D]
var activated : bool = false

signal on_activated(is_activated : bool)

func setup() -> void:
	for nodes in output_puzzles:
		on_activated.connect(nodes._on_recieve_input)
#	print("setup finish")

func send_input(stated : bool) -> void:
	activated = stated
	on_activated.emit(activated)
