class_name MainMenu
extends Control

@onready var start_button = $"MarginContainer/HBoxContainer/VBoxContainer/Start Button" as Button
@onready var quit_button = $"MarginContainer/HBoxContainer/VBoxContainer/Quit Button" as Button
@onready var start_level = preload("res://Scenes/splitscreen.tscn") as PackedScene
	#decides the scene to be loaded after clicking on start button

func _ready():
	start_button.button_down.connect(on_start_pressed)
	quit_button.button_down.connect(on_quit_pressed)

func on_start_pressed() -> void: #When clicked on start button
	get_tree().change_scene_to_packed(start_level)
	global.setup_level()
