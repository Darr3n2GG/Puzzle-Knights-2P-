extends Node

@onready var p2 = get_parent() as player
##Block instance
@onready var placed_block : RigidBody2D
##Check if block is in tree
var block_in_scene : bool = false
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

func _physics_process(_delta) -> void:
	if Input.is_action_just_pressed("2PlaceOrCarry"):
		if block_in_scene == false:
			Create_Block()
		elif not $"../TerrainDetector".has_overlapping_bodies():
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
	if not placed_block:
		var block = load("res://Creature/Barrel/Dummy.tscn")
		placed_block = block.instantiate()
		placed_block.set_name("block")
		p2.get_parent().add_child(placed_block)
	else:
		placed_block.Setup()
	Carry_Block()
	p2_states = states.carry
	block_in_scene = true
	
func Place_Block():
	$"../Barrel".visible = false
	$"../Carry_State_Collision".disabled = true
	placed_block.On_Placed()
	
func Carry_Block():
	$"../Barrel".visible = true
	$"../Carry_State_Collision".disabled = false
	placed_block.On_Create_or_Carry()
