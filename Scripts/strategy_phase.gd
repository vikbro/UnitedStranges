extends Node2D
class_name StrategyPhase

#@export
const MAIN_MENU = "res://Scenes/UI/main_menu.tscn"
const WIN = preload("uid://y4bain7ux7d4")
const LOSE = preload("uid://b055v31xj6ort")


func _ready() -> void:
	#Events.enter_level.connect()
	#Events.load_level()
	Events.level_win.connect(_win_level)
	Events.level_lose.connect(_lose_level)
	Events.enter_level.emit()
	AudioManager.african_drums.play()
	pass

func _win_level() -> void:
	var instance = WIN.instantiate()
	Events.stop_highlight.emit()
	Events.stop_camera_movemnt.emit()
	AudioManager.african_drums.stop()
	add_child(instance)
	
func _lose_level() -> void:
	var instance = LOSE.instantiate()
	Events.stop_highlight.emit()
	Events.stop_camera_movemnt.emit()
	AudioManager.african_drums.stop()
	add_child(instance)

func _on_main_menu_btn_pressed() -> void:
	SceneTransition.fade_to_scene(MAIN_MENU)
	AudioManager.button_click.play()
	Events.exit_level.emit()
	AudioManager.african_drums.stop()
