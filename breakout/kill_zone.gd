extends Area2D

signal dead

func _on_body_entered(body: Node2D) -> void:
	dead.emit()
