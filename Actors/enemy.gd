class_name Enemy
extends Area2D

@export var min_speed := 200.0
@export var max_speed := 350.0

var speed : float

func _ready() -> void:
	randomize()
	speed = randf_range(min_speed, max_speed)

func _physics_process(delta: float) -> void:
	move_local_x(speed * delta)

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullet"):
		queue_free()
		area.queue_free()


func _on_screen_exited() -> void:
	queue_free()
