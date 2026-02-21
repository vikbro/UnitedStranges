extends Camera2D

@export var strength: float = 20.0
@export var zoom_in_level: float = 2.0
@export var zoom_speed: float = 4.0
const SPEED := 6.0

var _locked := false
var _target_position := Vector2.ZERO
var _origin_position := Vector2.ZERO   # where the camera started
var _target_zoom := Vector2.ONE

func _ready() -> void:
	Events.kingdom_selected.connect(_on_kingdom_selected)
	Events.kingdom_deselected.connect(_on_kingdom_deselected)
	Events.start_camera_movemnt.connect(_on_start_camera_movement)
	Events.stop_camera_movemnt.connect(_on_stop_camera_movement)
	_target_zoom = zoom
	_origin_position = global_position  # store starting position
	_target_position = global_position

func _on_kingdom_selected(global_pos: Vector2) -> void:
	_locked = true
	_target_position = global_pos
	_target_zoom = Vector2.ONE * zoom_in_level

func _on_kingdom_deselected() -> void:
	_locked = false
	_target_position = _origin_position  # return to origin
	_target_zoom = Vector2.ONE

func _physics_process(delta: float) -> void:
	var weight := 1.0 - pow(0.01, delta * SPEED)
	zoom = lerp(zoom, _target_zoom, weight)

	if _locked:
		global_position = lerp(global_position, _target_position, weight)
		offset = lerp(offset, Vector2.ZERO, weight)
	else:
		# Keep lerping global_position back to origin even while unlocked
		global_position = lerp(global_position, _target_position, weight)
		var viewport_size := get_viewport_rect().size
		var mouse_pos := get_global_mouse_position() - viewport_size / 2.0
		var normalized := (mouse_pos / (viewport_size / 2.0)).clamp(Vector2(-1, -1), Vector2(1, 1))
		offset = lerp(offset, normalized * strength, weight)

func _on_stop_camera_movement() -> void:
	set_physics_process(false)

func _on_start_camera_movement() -> void:
	set_physics_process(true)
