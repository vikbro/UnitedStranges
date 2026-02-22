extends Node


func _ready() -> void:
	Dialogic.timeline_started.connect(Events.stop_highlight.emit)
	Dialogic.timeline_started.connect(Events.stop_camera_movemnt.emit)

	Dialogic.timeline_ended.connect(Events.start_highlight.emit)
	Dialogic.timeline_ended.connect(Events.start_camera_movemnt.emit)
	Events.start_dialogue.connect(_show_dialogue)

#func update_dialogic_allegience():
	##for kingdom: KingdomStats in DiplomacyManager.get_all_kingdoms():
		#
	##Dialogic.VAR.OPINIONS.set_variable("player_paper",0)
	#Dialogic.VAR.set("player_paper",0)

func update_dialogic_allegiance() -> void:
	var type_names := {
		KingdomStats.Type.PLAYER: "player",
		KingdomStats.Type.PAPER: "paper",
		KingdomStats.Type.SUN: "sun",
		KingdomStats.Type.VAMPIRE: "vampire",
		KingdomStats.Type.WAREWOLF: "warewolf",
	}

	print("=== Updating Dialogic Allegiances ===")

	for kingdom: KingdomStats in DiplomacyManager.get_all_kingdoms():
		var from_name: String = type_names.get(kingdom.kingdom_type, "")
		if from_name.is_empty():
			print("[SKIP] Unknown kingdom type: ", kingdom.kingdom_type)
			continue

		print("--- Kingdom: ", from_name, " ---")

		for other_type in kingdom.opinions.keys():
			var to_name: String = type_names.get(other_type, "")
			if to_name.is_empty():
				print("  [SKIP] Unknown opinion target type: ", other_type)
				continue

			var variable_name := "OPINIONS/%s_%s" % [from_name, to_name]
			var allegiance_value: int = kingdom.get_allegience(other_type)
			Dialogic.VAR.set(variable_name, allegiance_value)

			print("  SET ", variable_name, " = ", allegiance_value, " (", KingdomStats.AllegienceType.keys()[allegiance_value], ")")
	print("=== Done ===")

#func _show_dialogue(type:KingdomStats.Type):
	#
	#print("Start dialogue")
	#pass

func _show_dialogue(type: KingdomStats.Type) -> void:
	print("Start dialogue")

	var timeline_map := {
		KingdomStats.Type.PAPER: "paper_dialogue",
		KingdomStats.Type.SUN: "sun_dialogue",
		KingdomStats.Type.VAMPIRE: "vampire_dialogue",
		KingdomStats.Type.WAREWOLF: "werewolf_dialogue",
	}

	if not timeline_map.has(type):
		print("No timeline found for type: ", type)
		return

	var timeline: String = timeline_map[type]
	print("Starting timeline: ", timeline)
	Dialogic.start(timeline)
