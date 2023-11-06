extends Node

class_name Output_Puzzle

var activated : bool = false
var activation_index : int = 0

func Check_Activation() -> bool:
	if activated:
		activation_index += 1
	else:
		activation_index -= 1
	if activation_index == 1 and activated or activation_index == 0:
		return true
	else:
		return false
