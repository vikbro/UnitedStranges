extends Node2D

const TEST_TILE = preload("uid://bv8tx1bq51fl8")

func _ready() -> void:
	Events.play_splash.connect(_spawn_splash)

func _spawn_splash(pos:Vector2,color:Color) -> void:
	var instance: Node2D = TEST_TILE.instantiate()
	instance.modulate = color
	instance.position = pos
	add_child(instance)
