class_name Bullet
extends Area2D

@export var speed := 500.0

func _physics_process(delta: float) -> void:
	position.x += (speed * delta)
	rotation


func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()
