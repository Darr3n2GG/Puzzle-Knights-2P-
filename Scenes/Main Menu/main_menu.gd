class_name MainMenu
extends Control

@onready var start_button = $"MarginContainer/HBoxContainer/VBoxContainer/Start Button" as Button
@onready var quit_button = $"MarginContainer/HBoxContainer/VBoxContainer/Quit Button" as Button
@onready var start_level = preload("res://Scenes/Levels/level_1.tscn")

func _ready():
	start_button.button_down.connect(on_start_pressed)
	quit_button.button_down.connect(on_exit_pressed)
	

func on_start_pressed() -> void:
	pass

func on_exit_pressed() -> void:
	pass

