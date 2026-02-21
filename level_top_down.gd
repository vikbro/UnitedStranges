extends Node2D

const diplomats = preload("res://diplomats.tscn")

var friends = [3, 2, 1, 0]
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	#load the characters
	#load the non-interactable objects
	var diplomat_num: Array
	var diplomat
	for i in friends.size():
		#var p = rng.randf_range()
		diplomat = diplomats.instantiate()
		add_child(diplomat)
		#diplomat.position()
		diplomat_num.push_back(diplomat)
		print(diplomat_num[i])


func _process(delta: float) -> void:
	pass
