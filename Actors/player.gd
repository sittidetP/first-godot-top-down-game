class_name Player
extends CharacterBody2D

@export var speed := 200.0
@export var bullet : PackedScene

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		print("shoot")

func _physics_process(delta: float) -> void:
	handle_move()
	move_and_slide()
	
func handle_move():
	var direction_x = Input.get_axis("move_left", "move_right")
	var direction_y = Input.get_axis("move_forward", "move_back")
	velocity = Vector2(direction_x * speed, direction_y * speed)
