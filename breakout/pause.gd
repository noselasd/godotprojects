extends CanvasLayer

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().paused = !get_tree().paused
		visible = get_tree().paused
		
