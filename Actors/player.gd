class_name Player
extends CharacterBody2D


@export var speed := 200.0
@export var bullet : PackedScene

@onready var fire_timer: Timer = $FireTimer
@onready var enemy_detector: Area2D = $EnemyDetector

var fire_time : float

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot") and fire_timer.is_stopped():
		fire()
		

func _physics_process(delta: float) -> void:
	handle_move()
	move_and_slide()
	
func handle_move():
	var direction_x = Input.get_axis("move_left", "move_right")
	var direction_y = Input.get_axis("move_forward", "move_back")
	velocity = Vector2(direction_x * speed, direction_y * speed)

func fire():
	var mouse_position := get_global_mouse_position()
	var shooted_bullet := bullet.instantiate()
	shooted_bullet.position = global_position
	var bullet_rad := (mouse_position - global_position).angle()
	shooted_bullet.rotate(bullet_rad)
	get_parent().add_child(shooted_bullet)
	fire_timer.start()


func _on_enemy_detector_area_entered(area: Area2D) -> void:
	Events.death.emit()
	queue_free()
