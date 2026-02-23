extends Node2D
class_name StrategyPhase

#@export
const MAIN_MENU = "res://Scenes/UI/main_menu.tscn"
const WIN = preload("uid://y4bain7ux7d4")
const LOSE = preload("uid://b055v31xj6ort")
const LEVEL_TOP_DOWN = "res://level_top_down.tscn"

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = %Timer

@export var current_level:int
@export var strategy_timer: int = 60

func _ready() -> void:
	#Events.enter_level.connect()
	#Events.load_level()
	Events.level_win.connect(_win_level)
	Events.level_lose.connect(_lose_level)
	#Events.enter_level.emit()
	AudioManager.african_drums.play()
	timer.wait_time = strategy_timer
	timer.start()
	timer.timeout.connect(_transport_to_conference)
	if DiplomacyManager.check_win_condition() == true:
		Events.level_win.emit()
	elif DiplomacyManager.check_lose_condition() == true:
		Events.level_lose.emit()

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

func _transport_to_conference() -> void:
	var active_kingdoms : Array[KingdomStats]= DiplomacyManager.get_all_kingdoms()
	var random_kingdom = active_kingdoms.pick_random()
	
	animation_player.play("show_text_panel")
	await animation_player.animation_finished
	animation_player.play("diplomacy_slide")
	await animation_player.animation_finished
	animation_player.play("fade_out_text_panel")
	await animation_player.animation_finished

	SceneTransition.dissolve_to_level(LEVEL_TOP_DOWN,
	random_kingdom.level_scene,
	random_kingdom.background_img,current_level)
	
	#SceneTransition.dissolve_to_level(LEVEL_TOP_DOWN,
	#DiplomacyManager.kingdoms[KingdomStats.Type.PAPER].level_scene,
	#DiplomacyManager.kingdoms[KingdomStats.Type.PAPER].background_img,current_level)
	
	
	#active_kingdoms.
	#SceneTransition.dissolve_to_level()
	pass
