extends Node2D
class_name Game
const margin = 0
const MAX_LEVEL = 6
var cnt_bricks : int = 0
const BRICK_WIDTH :int = 96
const BRICK_HEIGTH :int = 32
var brick_scene = preload("res://brick.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Engine.time_scale = 1
	print("level ", GameManager.current_level)
	$LevelLabel.text = "Level " + str(GameManager.current_level)
	level_from_file("res://levels/level_" + str(GameManager.current_level) + ".txt")
	update_remaining()
	#random_level()
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://main_screen.tscn")
		

func add_brick(row: int, col: int, type: String):
	var color_map = {
		'R': Color.RED,
		'G': Color.GREEN,
		'B': Color.BLUE,
		'C': Color.CYAN,
		'+': Color.SANDY_BROWN
		
	}
	var brick : Brick = brick_scene.instantiate()
	var color = color_map.get(type)
	if color:
		brick.color = color
	if type == '+':
		brick.fixed = true
	else:
		cnt_bricks += 1
	brick.position = Vector2(BRICK_WIDTH/2 + col * (BRICK_WIDTH + 4), BRICK_HEIGTH/2 + row * (BRICK_HEIGTH + 4))
	add_child(brick)
	
	
func level_from_file(file):
	var f = FileAccess.open(file, FileAccess.READ)
	if not f:
		get_tree().change_scene_to_file("res://main_screen.tscn")
	
	var row = 0
	var col = 0
	cnt_bricks = 0
	while true:
		var l = f.get_line()
		
		if f.eof_reached():
			break
			
		for b in l:
			if b != ' ' and b != '\t':
				add_brick(row, col, b)
				
			if b == '\t':
				col += 4
			else:
				col += 1
		row += 1
		col = 0

	
func brick_color(row: int , col: int, colors: Array):

	if row < colors.size():
		return colors[row]
	return null
	
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
				brick.color = brick_color(r,c, colors)
			brick.position = Vector2(margin + c * (96 + 4), (margin + r * (32 + 4)))
			add_child(brick)
			cnt_bricks += 1

func update_remaining():
	$BricksLabel.text = str(cnt_bricks) + " left"
	
func level_finished():
	var timer = get_tree().create_timer(3,true,false,true)
	Engine.time_scale = 0.15
	await timer.timeout
	Engine.time_scale = 1
	if GameManager.current_level == MAX_LEVEL:
		get_tree().change_scene_to_file("res://done.tscn")
	else:
		GameManager.current_level += 1
		get_tree().reload_current_scene()
	
func _on_ball_brick_destroyed():
	cnt_bricks -= 1
	update_remaining()
	if cnt_bricks == 0:
		level_finished()

func _on_kill_zone_dead() -> void:
	get_tree().reload_current_scene()
