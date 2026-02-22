extends Node

#const DIALOGUE_PHASE_LEVEL = "res://Scenes/Level/dialogue_phase_level.tscn"
const LEVEL_TOP_DOWN = "res://level_top_down.tscn"
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass


func _on_paper_transport_pressed() -> void:
	#animation_player.play("show_text_panel")
	#await animation_player.animation_finished
	#animation_player.play("diplomacy_slide")
	#await animation_player.animation_finished
	#animation_player.play("fade_out_text_panel")
	#await animation_player.animation_finished
	$"../.."._transport_to_conference()
	#SceneTransition.dissolve_to_level(LEVEL_TOP_DOWN,
	#DiplomacyManager.kingdoms[KingdomStats.Type.PAPER].level_scene,
	#DiplomacyManager.kingdoms[KingdomStats.Type.PAPER].background_img,1)
	
	pass # Replace with function body.
