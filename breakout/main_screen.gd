extends Control

var ball = preload("res://ball.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://game.tscn")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	$StartLabel/AnimationPlayer.play("blink") # Replace with function body.

func add_ball():
	print("Adding ball")
	var b : Ball = ball.instantiate()
	b.sound_on = false
	var r = get_viewport_rect()
	b.position = r.get_center()
	add_child(b)
	
	
