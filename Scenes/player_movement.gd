extends CharacterBody2D
class_name Player

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var npc_dialogue: Area2D = $npc_dialogue

const SPEED = 300.0
var in_dialogue: bool = false
var nearby_diplomat: Diplomat = null

func _ready() -> void:
	Dialogic.timeline_started.connect(_on_dialogue_started)
	Dialogic.timeline_ended.connect(_on_dialogue_ended)
	npc_dialogue.body_entered.connect(_on_npc_dialogue_body_entered)
	npc_dialogue.body_exited.connect(_on_npc_dialogue_body_exited)

func _on_dialogue_started() -> void:
	in_dialogue = true
	velocity = Vector2.ZERO
	_update_animation(Vector2.ZERO)

func _on_dialogue_ended() -> void:
	in_dialogue = false

func _on_npc_dialogue_body_entered(body: Node2D) -> void:
	print("Detected diplomat")
	if body is Diplomat:
		nearby_diplomat = body
		body.input_panel.show()

func _on_npc_dialogue_body_exited(body: Node2D) -> void:
	print("EXIT diplomat")
	
	if body is Diplomat:
		nearby_diplomat = null
		body.input_panel.hide()

func _process(delta: float) -> void:
	if in_dialogue:
		velocity = Vector2.ZERO
		move_and_slide()
		return

	if nearby_diplomat and Input.is_action_just_pressed("talk"):
		nearby_diplomat.start_dialogue()
		return

	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * SPEED
	move_and_slide()
	_update_animation(direction)

func _update_animation(direction: Vector2) -> void:
	if direction == Vector2.ZERO:
		animation_player.play("walk_down")
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
