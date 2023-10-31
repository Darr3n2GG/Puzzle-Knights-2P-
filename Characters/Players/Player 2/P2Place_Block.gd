extends Node

@onready var p2 = get_parent() as player
##Block instance
var placed_block : RigidBody2D
##Check if block is in tree
var has_block : bool = false
##Distance from block
var dist : float

##Player 2 States dictionary :
##carry - when player is carrying the block
##placed - when player has placed the block
enum states
{
	carry,
	placed
}
##Player 2 state variable
var p2_states = states.placed

func _input(_event):
	if Input.is_action_just_pressed("2PlaceOrCarry"):
		if has_block == false:
			Create_Block()
		else:
			if is_instance_valid(placed_block):
				if not $"../TerrainDetector".has_overlapping_bodies():
					match p2_states:
						states.placed:
							dist = p2.global_position.distance_to(placed_block.global_position)
							if dist < 100:
								Carry_Block()
								p2_states = states.carry
						states.carry:
							Place_Block()
							p2_states = states.placed
							
func Create_Block(): 
	var block = load("res://Creature/Dummy.tscn")
	placed_block = block.instantiate()
	placed_block.set_name("block")
	p2.get_parent().add_child(placed_block)
	Carry_Block()
	p2_states = states.carry
	has_block = true
	
func Place_Block():
	$"../Block".visible = false
	$"../Carry_State_Collision".disabled = true
	placed_block.On_Placed()
	
func Carry_Block():
	$"../Block".visible = true
	$"../Carry_State_Collision".disabled = false
	placed_block.On_Create_or_Carry()
