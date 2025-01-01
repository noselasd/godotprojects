extends Area2D
signal level_finished

func _on_body_entered(body: Node2D) -> void:
	level_finished.emit()
