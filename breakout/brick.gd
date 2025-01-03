extends StaticBody2D
class_name Brick

@export var fixed = false
func _ready():
	$CPUParticles2D.color = self.modulate
func hit() -> void:
	if fixed:
		return
	$CollisionShape2D.disabled = true
	$Sprite2D.visible = false
	$CPUParticles2D.emitting = true
	var timer = get_tree().create_timer(1, false)
	await timer.timeout
	queue_free()
	
