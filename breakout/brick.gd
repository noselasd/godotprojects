extends StaticBody2D
class_name Brick
 
func hit() -> void:
	$CollisionShape2D.disabled = true
	$Sprite2D.visible = false
	$CPUParticles2D.emitting = true
	var timer = get_tree().create_timer(1, false)
	await timer.timeout
	queue_free()
