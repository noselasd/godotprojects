extends CharacterBody2D
class_name Ball

signal brick_destroyed
@onready var hit_sound: AudioStreamPlayer2D = $HitSound
@onready var bounce_sound: AudioStreamPlayer2D = $BounceSound


@export var sound_on : bool = true
@export var speed : float = 600.0
var speedup = 1.003 # .3% speedup each paddle hit
func _ready():
	velocity = Vector2(-1 * speed, speed)
	if not sound_on:
		hit_sound.volume_db = -1000
		bounce_sound.volume_db = -1000

func play_hit_sound():
	hit_sound.pitch_scale = randf_range(0.8,1.2)
	hit_sound.play()
	
func play_bounce_sound():
	bounce_sound.pitch_scale = randf_range(0.9,1.1)
	bounce_sound.play()
	
func _physics_process(delta: float) -> void:

	var collision = move_and_collide(velocity * delta)
	if collision:
		play_bounce_sound()
	#	v_before = velocity
		var v_before = velocity
		velocity = velocity.bounce(collision.get_normal())
		var collider = collision.get_collider()
		var brick : Brick = collider as Brick
		if brick and not brick.fixed:
			play_hit_sound()
			brick.hit()
			brick_destroyed.emit()
			
		elif collider is Paddle:
			print("Velocity Before", v_before)
			print("Velocity After ", velocity)
			velocity *= speedup
			position.y -= 2 # helps multiple collision when moving paddle as ball hits
		# prevent horizontal/vertical  jam
		if velocity.y >= -50 and velocity.y < 0:
			velocity.x -= -50
			velocity.y += 50
			print("Y stuck1")
		elif velocity.y <= 50 and velocity.y >= 0:
			velocity.x += 50 
			velocity.y -= 25
			print("Y stuck1")
			
		
		if velocity.x >= -50 and velocity.x < 0:
			velocity.x -= -50
			velocity.y += 50
			print("X stuck1")
		elif velocity.x <= 25 and velocity.x >= 0:
			velocity.x += 50 
			velocity.y -= 50
			print("X stuck2")
		
