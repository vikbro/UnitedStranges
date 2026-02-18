extends Node
## Helper to handle dialogue choices affecting kingdom opinions
## Connects Dialogic events to opinion modifications

class_name DialogueOpinionHelper

var kingdom_manager: KingdomManager


func _ready() -> void:
	kingdom_manager = get_tree().get_first_node_in_group("kingdom_manager")
	if not kingdom_manager:
		push_error("DialogueOpinionHelper: KingdomManager not found in scene")


## Called when dialogue choice affects opinion
## Example usage in Dialogic:
## DialogueOpinionHelper.apply_opinion_change(KingdomStats.Type.PAPER, KingdomStats.Type.PLAYER, 20)
func apply_opinion_change(kingdom_type: int, target_type: int, amount: int) -> void:
	if kingdom_manager:
		kingdom_manager.modify_opinion(kingdom_type, target_type, amount)
	else:
		push_error("DialogueOpinionHelper: KingdomManager not available")


## Get current opinion for UI display
func get_kingdom_opinion_of_target(kingdom_type: int, target_type: int) -> int:
	if kingdom_manager:
		return kingdom_manager.get_direct_opinion(kingdom_type, target_type)
	return 0


## Called at end of dialogue phase
func finalize_dialogue_phase() -> void:
	if kingdom_manager:
		kingdom_manager.calculate_all_opinions()
