extends Node2D
class_name Game
const margin = 200
const rows = 5
const cols = 15
var cnt_bricks : int = 0
var brick_scene = preload("res://brick.tscn")
var colors = [
		Color.BLUE,
		Color.GREEN,
		Color.RED,
		Color.GOLD
		]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Engine.time_scale = 1
	colors.shuffle()
	
	for c in cols:
		for r in rows:
			var brick : Brick = brick_scene.instantiate()
			var color = brick_color(r,c)
			if color:
				brick.modulate = brick_color(r,c)
			brick.position = Vector2(margin + c * (96 + 4), (margin + r * (32 + 4)))
			add_child(brick)
	cnt_bricks = rows * cols
	$BricksLabel.text = str(cnt_bricks) + " left"
	
func brick_removed():
	cnt_bricks -= 1
	$BricksLabel.text = str(cnt_bricks) + " left"
	if cnt_bricks == 0:
		var timer = get_tree().create_timer(3,true,false,true)
		Engine.time_scale = 0.15
		await timer.timeout
		Engine.time_scale = 1
		
		get_tree().reload_current_scene()
	
func brick_color(row: int , col: int):

	if row < colors.size():
		return colors[row]
	return null
