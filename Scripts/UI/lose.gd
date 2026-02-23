extends CanvasLayer

const LEVEL_SELECTION = "res://Scenes/UI/LevelSelection.tscn"

func _ready() -> void:
	AudioManager.lose.play()



func _on_button_pressed() -> void:
	SceneTransition.fade_to_scene(LEVEL_SELECTION)
	AudioManager.button_click.play()
	Events.exit_level.emit()
	pass # Replace with function body.
