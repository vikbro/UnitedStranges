extends Node2D
@onready var timer: Timer = %Timer

#const diplomats = preload("res://diplomats.tscn")

@export var round_time_sec : int = 30

var friends = [1, 2, 3, 4]
#var rng = RandomNumberGenerator.new()

func _ready() -> void:
	timer.wait_time = round_time_sec
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
	SceneTransition.fade_to_scene("res://Scenes/UI/main_menu.tscn")
