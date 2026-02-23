extends Node2D
@onready var timer: Timer = %Timer

#const diplomats = preload("res://diplomats.tscn")
const LEVEL_1 = "res://Scenes/Levels/Level_1.tscn"
const LEVEL_2 = "res://Scenes/Levels/Level_2.tscn"
const STRATEGY_LAYOUT = "res://Scenes/strategy_layout.tscn"

@export var round_time_sec : int = 30
@export var called_from_level: int

var friends = [1, 2, 3, 4]
#var rng = RandomNumberGenerator.new()

func _ready() -> void:
	timer.wait_time = round_time_sec
	#timer.start()
	#load the characters
	#load the non-interactable objects
	#Events.player_enter.connect(_interaction)
	#var diplomat_num: Array
	#var diplomat
	#for i in friends.size():
#		var p = rng.randf_range(0, 1000)
		#diplomat = diplomats.instantiate()
		#add_child(diplomat)
#		diplomat.position = Vector2(1*p, 1*p)
		#diplomat_num.push_back(diplomat)
		#print(diplomat_num[i])

func _process(delta: float) -> void:
	pass

func _interaction():
	print("l")


func _on_timer_timeout() -> void:
	DiplomacyManager._simulate_diplomacy()
	Dialogic.end_timeline()
	_transition_to_strategy()
	#SceneTransition.fade_to_scene("res://Scenes/UI/main_menu.tscn")

func _transition_to_strategy() -> void:
	#DiplomacyManager._simulate_diplomacy()
	
	if called_from_level == 1:
		SceneTransition.fade_to_level(STRATEGY_LAYOUT,LEVEL_1,1)
	elif called_from_level == 2:
		SceneTransition.fade_to_level(STRATEGY_LAYOUT,LEVEL_2,2)
	
	elif called_from_level == 3:
		pass
	pass
