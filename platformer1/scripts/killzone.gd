extends Area2D
@onready var timer: Timer = $Timer


func _on_body_entered(body: Node2D) -> void:
	timer.start()
	Engine.time_scale = 0.5
	# Remove collision shape so player falls down
	# (when e.g. hitting an enemy)
	if body.name == "Player":
		body.get_node('CollisionShape2D').queue_free()
		body.velocity.y = 0
		print("you died")


func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()
