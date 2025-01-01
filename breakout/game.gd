extends Node2D

const margin = 200
const rows = 2
const cols = 15
var brick_scene = preload("res://brick.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for c in cols:
		for r in rows:
			var brick : Brick = brick_scene.instantiate()
			brick.position = Vector2(margin + c * (96 + 4), (margin + r * (32 + 4)))
			add_child(brick)
			
			
