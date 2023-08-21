extends Node

@export var enemy : PackedScene
@export var player_scene : PackedScene

@onready var score_label: Label = $UICanvasLayer/ScoreLabel
@onready var time_label: Label = $UICanvasLayer/TimeLabel

@onready var enemy_spawn_position1: PathFollow2D = $EnemyPath/EnemySpawnPosition1
@onready var enemy_spawn_position2: PathFollow2D = $EnemyPath/EnemySpawnPosition2
@onready var ui_canvas_layer: CanvasLayer = $UICanvasLayer
@onready var game_name_canvas_layer: CanvasLayer = $GameNameCanvasLayer
@onready var mob_timer: Timer = $MobTimer

var score : int = 0
var start_time : float = 0
var is_game_start : bool = false
var player_center_pos : Vector2
var player : Player

const SCORE_STR := "Score : %s"

func _ready() -> void:
	var center_pos := get_viewport().get_visible_rect().size / 2
	player_center_pos = Vector2(center_pos.x, center_pos.y)
	Events.score_up.connect(increas_score)
	Events.death.connect(game_over)
	mob_timer.stop()
	
func start_game() -> void:
	remove_all_enemy()
	is_game_start = true
	mob_timer.start()
	ui_canvas_layer.visible = true
	player = player_scene.instantiate()
	player.position = player_center_pos
	add_child(player)
	score = 0
	score_label.text = SCORE_STR % score
	start_time = Time.get_ticks_msec()
	randomize()

func _process(delta: float) -> void:
	if is_game_start:
		var current_time := (Time.get_ticks_msec() - start_time) / 1000
		time_label.text = str(round(current_time))
		
func remove_all_enemy() -> void:
	var enemies := get_tree().get_nodes_in_group("enemies")
	for enemy in enemies:
		enemy.queue_free()

func increas_score() -> void:
	score+=1
	score_label.text = SCORE_STR % score

func game_over() -> void:
	is_game_start = false
	mob_timer.stop()
	game_name_canvas_layer.visible = true

func _on_mob_timer_timeout() -> void:
	var player_position := Vector2.ZERO
	if player != null:
		player_position = player.position
	if is_game_start:
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
