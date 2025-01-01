extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var jump_audio: AudioStreamPlayer = $AudioStreamPlayer
var rng = RandomNumberGenerator.new()
# leeway to jump right after falling
const COYOTE_LEEWAY = 0.15
var coyote_time : float = 0.0
var jumping : bool = false

func on_jump():
	velocity.y = JUMP_VELOCITY
	jumping = true
	jump_audio.pitch_scale = rng.randf_range(0.9,1.1)
	jump_audio.play()
	
func _physics_process(delta: float) -> void:
	# Add the gravity.

	if not is_on_floor():
		velocity += get_gravity() * delta
	if is_on_floor():
		jumping = false
		coyote_time = 0
	elif not jumping:
		coyote_time += delta
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor():
			on_jump()
		elif velocity.y > 0 and coyote_time <= COYOTE_LEEWAY and jumping == false:
			on_jump()
			print("coyote jump")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	# flip sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	# Play animation
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
	
	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
func _on_finish_level_level_finished() -> void:
	# disable all movement etc. for player
	set_physics_process(false)
