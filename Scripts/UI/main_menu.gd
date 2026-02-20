extends Control

@onready var layer_1: Control = $LayeredBackgorund1
@onready var layer_2: Control = $LayeredBackgorund2

const LEVEL_SELECTION = "res://Scenes/UI/LevelSelection.tscn"


@onready var bg1 := [
	$LayeredBackgorund1/Background0,
	$LayeredBackgorund1/Background1,
	$LayeredBackgorund1/Background2,
	$LayeredBackgorund1/Background3,
]
@onready var bg2 := [
	$LayeredBackgorund2/Background0,
	$LayeredBackgorund2/Background1,
	$LayeredBackgorund2/Background2,
	$LayeredBackgorund2/Background3,
]

@export var backgrounds: Array[ParalaxBGData]
@export var display_time: float = 4.0   # how long each background shows
@export var fade_time: float = 1.5      # how long the crossfade takes

const SPEED := 6.0
const PARALLAX_STRENGTHS := [0.01, 0.02, 0.06, 0.04]

var _current_index := 0
var _next_index := 1
var _fade_timer := 0.0
var _hold_timer := 0.0
var _is_fading := false
var _active_layer: Control
var _incoming_layer: Control

func _ready() -> void:
	if backgrounds.is_empty():
		return

	_active_layer = layer_1
	_incoming_layer = layer_2

	_load_background(bg1, backgrounds[_current_index])
	_load_background(bg2, backgrounds[_next_index])

	layer_1.modulate.a = 1.0
	layer_2.modulate.a = 0.0

func _physics_process(delta: float) -> void:
	_update_parallax(delta)
	_update_crossfade(delta)

func _update_parallax(delta: float) -> void:
	var mouse_pos := get_global_mouse_position() - get_viewport_rect().size / 2.0
	var weight := 1.0 - pow(0.01, delta * SPEED)

	for i in 4:
		bg1[i].position = lerp(bg1[i].position, mouse_pos * PARALLAX_STRENGTHS[i], weight)
		bg2[i].position = lerp(bg2[i].position, mouse_pos * PARALLAX_STRENGTHS[i], weight)

func _update_crossfade(delta: float) -> void:
	if backgrounds.size() < 2:
		return

	if _is_fading:
		_fade_timer += delta
		var t := clampf(_fade_timer / fade_time, 0.0, 1.0)
		_active_layer.modulate.a = 1.0 - t
		_incoming_layer.modulate.a = t

		if t >= 1.0:
			# Fade complete — swap layers
			_is_fading = false
			_fade_timer = 0.0
			_hold_timer = 0.0

			var temp = _active_layer
			_active_layer = _incoming_layer
			_incoming_layer = temp

			# Advance index and preload next background into the now-hidden layer
			_current_index = _next_index
			_next_index = (_next_index + 1) % backgrounds.size()
			var incoming_textures := bg1 if _incoming_layer == layer_1 else bg2
			_load_background(incoming_textures, backgrounds[_next_index])
	else:
		_hold_timer += delta
		if _hold_timer >= display_time:
			_is_fading = true

func _load_background(targets: Array, data: ParalaxBGData) -> void:
	targets[0].texture = data.texture_0
	targets[1].texture = data.texture_1
	targets[2].texture = data.texture_2
	targets[3].texture = data.texture_3

func _on_button_pressed() -> void:
	SceneTransition.fade_to_scene(LEVEL_SELECTION)
	#get_tree().change_scene_to_file("res://Scenes/strategy_layout.tscn")
	pass # Replace with function body.
