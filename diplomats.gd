extends CharacterBody2D
@onready var area: Area2D = $Area2D

func _ready() -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("hi")
	Events.player_enter.emit()
