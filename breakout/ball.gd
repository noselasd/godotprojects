extends CharacterBody2D
class_name Ball

const SPEED = 600.0
func _ready():
	velocity = Vector2(-1 * SPEED, SPEED)
	
func _physics_process(delta: float) -> void:

	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal())
		print("v:",velocity, "c:", collision.get_position())
	
		
	
