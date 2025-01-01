extends Node
class_name GameManager
var score : int = 0
@onready var score_label: Label = %Score
# current level number, used to load next level
@export var level_no: int = 0
@onready var finish_timer: Timer = $Timer
var level_transition = preload("res://scenes/level_transition.tscn")

func _ready():
	run_level_transition(true)
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://scenes/start_screen.tscn")
		
func run_level_transition(start: bool):
	var transition : LevelTransition = level_transition.instantiate()
	add_child(transition)
	if start:
		transition.fade_to_transparent()
	else:
		transition.fade_to_black()

func add_point():
	score += 1
	score_label.text = str(score)

func reset_score():
	score = 0

func _on_finish_level_level_finished() -> void:
	run_level_transition(false)
	finish_timer.start()

func start_next_level() -> void:
	var next_level = 'res://levels/level_' + str(level_no + 1) + ".tscn"
	print("loading level " + next_level)
	var err = get_tree().change_scene_to_file(next_level)
	if err != OK:
		print("Error loading level: " + str(err))
		get_tree().change_scene_to_file('res://scenes/start_screen.tscn')

func _on_finish_timer_timeout() -> void:
	start_next_level()
