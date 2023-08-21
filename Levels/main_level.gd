extends Node

@export var enemy : PackedScene

@onready var score_label: Label = $UICanvasLayer/ScoreLabel
@onready var time_label: Label = $UICanvasLayer/TimeLabel

@onready var enemy_spawn_position1: PathFollow2D = $EnemyPath/EnemySpawnPosition1
@onready var enemy_spawn_position2: PathFollow2D = $EnemyPath/EnemySpawnPosition2
@onready var ui_canvas_layer: CanvasLayer = $UICanvasLayer
@onready var game_name_canvas_layer: CanvasLayer = $GameNameCanvasLayer
@onready var mob_timer: Timer = $MobTimer
@onready var player: Player = $Player

var score : int = 0
var start_time : float = 0

const SCORE_STR := "Score : %s"

func _ready() -> void:
	Events.score_up.connect(increas_score)
	mob_timer.stop()
	
func start_game() -> void:
	mob_timer.start()
	ui_canvas_layer.visible = true
	score = 0
	score_label.text = SCORE_STR % score
	start_time = Time.get_ticks_msec()
	randomize()

func _process(delta: float) -> void:
	if player == null:
		mob_timer.stop()
		game_name_canvas_layer.visible = true
	else:
		var current_time := (Time.get_ticks_msec() - start_time) / 1000
		time_label.text = str(round(current_time))

func increas_score() -> void:
	score+=1
	score_label.text = SCORE_STR % score

func _on_mob_timer_timeout() -> void:
	var player_position := Vector2.ZERO
	if player != null:
		player_position = player.position
	spawn_eneny(enemy_spawn_position1, player_position)
	spawn_eneny(enemy_spawn_position2, player_position)
	
func spawn_eneny(enemy_spawner: PathFollow2D, target_position: Vector2) -> void:
	enemy_spawner.progress_ratio = randf()
	var mob := enemy.instantiate()
	mob.rotation = (target_position - enemy_spawner.position).angle()
	mob.position = enemy_spawner.position
	add_child(mob)


func _on_start_button_pressed() -> void:
	game_name_canvas_layer.visible = false
	start_game()


func _on_quit_button_pressed() -> void:
	get_tree().quit()
