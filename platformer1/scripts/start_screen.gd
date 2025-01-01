extends Control

var start_level = preload("res://levels/level_1.tscn")
@onready var start_button: Button = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/StartButton

func _ready() -> void:
	start_button.grab_focus()
	
func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_packed(start_level)
