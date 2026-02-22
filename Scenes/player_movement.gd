extends CharacterBody2D
class_name Player

@onready var animation_player: AnimationPlayer = $AnimationPlayer

const SPEED = 300.0

func _process(delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * SPEED
	move_and_slide()
	_update_animation(direction)

func _update_animation(direction: Vector2) -> void:
	if direction == Vector2.ZERO:
		animation_player.play("walk_down")  # idle pose
		animation_player.pause()
		return
	
	if abs(direction.x) >= abs(direction.y):
		if direction.x > 0:
			animation_player.play("walk_right")
		else:
			animation_player.play("walk_left")
	else:
		if direction.y > 0:
			animation_player.play("walk_down")
		else:
			animation_player.play("walk_up")
