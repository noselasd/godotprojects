extends StaticBody2D
class_name Brick

@export var fixed = false
@export var color : Color = Color.TRANSPARENT

func _ready():
	if color !=  Color.TRANSPARENT:
		modulate = self.color
		$CPUParticles2D.color = self.color
func hit() -> void:
	if fixed:
		return
	$CollisionShape2D.disabled = true
	$Sprite2D.visible = false
	$CPUParticles2D.emitting = true
	var timer = get_tree().create_timer(1, false)
	await timer.timeout
	queue_free()
	
