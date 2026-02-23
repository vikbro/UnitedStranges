extends Node2D

@onready var npc: Node2D = $NPC

func _ready() -> void:
	hide_non_participating_kingdoms()

#Ensure only the kingdoms that are included in the level are introduced
func hide_non_participating_kingdoms() -> void:
	var loaded_kingdoms: Array[KingdomStats] = DiplomacyManager.get_all_kingdoms()

	# Extract just the types for easy lookup
	var loaded_types: Array[KingdomStats.Type] = []
	for kingdom in loaded_kingdoms:
		loaded_types.append(kingdom.kingdom_type)

	for child in npc.get_children():
		if child is Diplomat:
			if !loaded_types.has(child.diplomat_type):
				child.queue_free()
	
	
