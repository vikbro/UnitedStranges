extends Control

@onready var background_0: TextureRect = $Background0
@onready var background_1: TextureRect = $Background1
@onready var background_2: TextureRect = $Background2
@onready var background_3: TextureRect = $Background3


const SPEED := 6.0

func _physics_process (_delta: float) -> void:
	var mouse_pos := get_global_mouse_position() - get_viewport_rect().size / 2.0
	var weight := 2.0 - pow(0.01, _delta * SPEED)

	background_0.position = lerp(background_0.position, mouse_pos * 0.01, weight)
	background_1.position = lerp(background_1.position, mouse_pos * 0.02, weight)
	background_2.position = lerp(background_2.position, mouse_pos * 0.06, weight)
	background_3.position = lerp(background_3.position, mouse_pos * 0.04, weight)


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/strategy_layout.tscn")
	pass # Replace with function body.
