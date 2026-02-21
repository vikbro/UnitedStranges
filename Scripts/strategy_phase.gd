extends Node2D
class_name StrategyPhase

#@export
const MAIN_MENU = "res://Scenes/UI/main_menu.tscn"


func _ready() -> void:
	#Events.load_level()
	pass


func _on_main_menu_btn_pressed() -> void:
	SceneTransition.fade_to_scene(MAIN_MENU)
	AudioManager.button_click.play()

	pass # Replace with function body.
