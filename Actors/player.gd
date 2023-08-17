class_name Player
extends CharacterBody2D

@export var speed := 200.0

func _physics_process(delta: float) -> void:
	var direction_x = Input.get_axis("move_left", "move_right")
	var direction_y = Input.get_axis("move_forward", "move_back")
	velocity = Vector2(direction_x * speed, direction_y * speed)
	move_and_slide()
