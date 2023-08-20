extends Node

@export var enemy : PackedScene

@onready var enemy_spawn_position: PathFollow2D = $EnemyPath/EnemySpawnPosition

func _ready() -> void:
	randomize()

func _process(delta: float) -> void:
	pass



func _on_mob_timer_timeout() -> void:
	var player := get_node("Player")
	var player_position := Vector2.ZERO
	if player != null:
		player_position = player.position
	enemy_spawn_position.progress_ratio = randf()
	var mob := enemy.instantiate()
	mob.rotation = (player_position - enemy_spawn_position.position).angle()
#	mob.rotation += randf_range(-PI/4, PI/4)
	mob.position = enemy_spawn_position.position
	add_child(mob)
