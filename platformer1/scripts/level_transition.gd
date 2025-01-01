extends Node
class_name LevelTransition
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func fade_to_black() -> void:
	animation_player.play("fade_to_black")

func fade_to_transparent() -> void:
	animation_player.play("fade_to_transparent")

func _on_animation_finished(anim_name: StringName) -> void:
	print(self)
	get_parent().remove_child(self)
