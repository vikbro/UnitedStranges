extends Node

const DIALOGUE_PHASE_LEVEL = "res://Scenes/Level/dialogue_phase_level.tscn"
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass


func _on_paper_transport_pressed() -> void:
	animation_player.play("show_text_panel")
	await animation_player.animation_finished
	animation_player.play("diplomacy_slide")
	await animation_player.animation_finished
	animation_player.play("fade_out_text_panel")
	await animation_player.animation_finished
	
	SceneTransition.dissolve_to_scene(DIALOGUE_PHASE_LEVEL,DiplomacyManager.kingdoms[KingdomStats.Type.PAPER].background_img)
	
	pass # Replace with function body.
