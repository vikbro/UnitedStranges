extends CharacterBody2D
class_name Diplomat

@export var diplomat_type : KingdomStats.Type
@onready var area: Area2D = $Area2D

func _ready() -> void:
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	#Events.player_enter.emit(diplomat_type)
	pass
