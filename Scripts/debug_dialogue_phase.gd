extends Node

const DIALOGUE_PHASE_LEVEL = preload("uid://sccvf5bptkd3")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_paper_transport_pressed() -> void:
	
	SceneTransition.change_scene_to_node(DIALOGUE_PHASE_LEVEL.instantiate(),DiplomacyManager.kingdoms[KingdomStats.Type.PAPER].background_img)
	
	pass # Replace with function body.
