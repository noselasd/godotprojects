extends CharacterBody2D
class_name Ball

@export var game : Game
signal brick_destroyed

var speed = 600.0
var speedup = 1.003 # .3% speedup each paddle hit
func _ready():
	velocity = Vector2(-1 * speed, speed)
	
func _physics_process(delta: float) -> void:

	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal())
		var collider = collision.get_collider()
		var brick : Brick = collider as Brick
		if brick and not brick.fixed:
			brick.hit()
			brick_destroyed.emit()
			
		elif collider is Paddle:
			velocity *= speedup
		# prevent horizontal jam
		if velocity.y >= -50 and velocity.y < 0:
			velocity.y = -speed/2
		elif velocity.y <= 50 and velocity.y >= 0:
			velocity.y = speed/2
	
