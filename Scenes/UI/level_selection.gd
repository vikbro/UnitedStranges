extends Control

const MAIN_MENU = "res://Scenes/UI/main_menu.tscn"
const LEVEL_1 = "res://Scenes/Levels/Level_1.tscn"
const LEVEL_2 = "res://Scenes/Levels/Level_2.tscn"
const STRATEGY_LAYOUT = "res://Scenes/strategy_layout.tscn"


func _on_lvl_1_pressed() -> void:
	AudioManager.button_click.play()
	SceneTransition.fade_to_level(STRATEGY_LAYOUT,LEVEL_1,1)
	Events.transition_load.connect(Events.enter_level.emit)
	#Events.enter_level.emit()
	#SceneTransition.fade_to_scene(LEVEL_1)
	
	pass # Replace with function body.


func _on_lvl_2_pressed() -> void:
	AudioManager.button_click.play()
	SceneTransition.fade_to_level(STRATEGY_LAYOUT,LEVEL_2,2)
	Events.transition_load.connect(Events.enter_level.emit)

	#SceneTransition.fade_to_scene(LEVEL_2)
	
	pass # Replace with function body.


func _on_lvl_3_pressed() -> void:
	AudioManager.button_click.play()
	pass # Replace with function body.


func _on_lvl_4_pressed() -> void:
	AudioManager.button_click.play()
	pass # Replace with function body.


func _on_lvl_5_pressed() -> void:
	AudioManager.button_click.play()
	pass # Replace with function body.


func _on_back_btn_pressed() -> void:
	AudioManager.button_click.play()
	SceneTransition.fade_to_scene(MAIN_MENU)

	pass # Replace with function body.
