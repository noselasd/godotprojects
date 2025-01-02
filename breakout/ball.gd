extends CharacterBody2D
class_name Ball
@export var game : Game
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
		if brick:
			brick.hit()
			game.brick_removed()
			
		elif collider is Paddle:
			velocity *= speedup
		# preent horizontal jam
		if velocity.y >= -50 and velocity.y < 0:
			velocity.y = -speed/2
		elif velocity.y <= 50 and velocity.y >= 0:
			velocity.y = speed/2
	
