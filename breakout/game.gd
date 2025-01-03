extends Node2D
class_name Game
const margin = 100

var cnt_bricks : int = 0
var brick_scene = preload("res://brick.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Engine.time_scale = 1
	level_from_file("res://levels/level_2.txt")
	#random_level()
func add_brick(row:int, col:int, type: String):
	var color_map = {
		'R': Color.RED,
		'G': Color.GREEN,
		'B': Color.BLUE
	}
	var brick : Brick = brick_scene.instantiate()
	print("adding brick: ", type)
	var color = color_map.get(type)
	if color:
		brick.modulate = color
	brick.position = Vector2(margin + col * (96 + 4), (margin + row * (32 + 4)))
	add_child(brick)
func level_from_file(file):
	var f = FileAccess.open(file, FileAccess.READ)
	
	var row = 0
	var col = 0
	cnt_bricks = 0
	while true:
		var l = f.get_line()
		
		if l == '' and f.eof_reached():
			break
		for b in l:
			if b != ' ' and b != '\t':
				add_brick(row, col, b)
				cnt_bricks += 1
			if b == '\t':
				col += 4
			else:
				col += 1
			printraw(b)
		printraw("\n")
		row += 1
		col = 0
		
func random_level():
	const max_rows = 5
	const max_cols = 12
	var colors = [
		Color.BLUE,
		Color.GREEN,
		Color.RED,
		Color.GOLD
		]
	colors.shuffle()
	cnt_bricks = 0
	for c in randi_range(1,max_cols):
		for r in randi_range(1,max_rows):
			var brick : Brick = brick_scene.instantiate()
			var color = brick_color(r,c, colors)
			if color:
				brick.modulate = brick_color(r,c, colors)
			brick.position = Vector2(margin + c * (96 + 4), (margin + r * (32 + 4)))
			add_child(brick)
			cnt_bricks += 1
			
	update_remaining()

func update_remaining():
	$BricksLabel.text = str(cnt_bricks) + " left"
func brick_removed():
	cnt_bricks -= 1
	update_remaining()
	if cnt_bricks == 0:
		var timer = get_tree().create_timer(3,true,false,true)
		Engine.time_scale = 0.15
		await timer.timeout
		Engine.time_scale = 1
		
		get_tree().reload_current_scene()
	
func brick_color(row: int , col: int, colors: Array):

	if row < colors.size():
		return colors[row]
	return null
