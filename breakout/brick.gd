extends Area2D
class_name Brick
 
func _on_body_entered(body: Node2D) -> void:
	var ball : Ball = body as Ball
	if ball:
		ball.velocity = ball.velocity * -1
		queue_free()
