extends Node


func _ready() -> void:
	Dialogic.timeline_started.connect(Events.stop_highlight.emit)
	Dialogic.timeline_ended.connect(Events.start_highlight.emit)

func update_dialogic_allegience():
	#for kingdom: KingdomStats in DiplomacyManager.get_all_kingdoms():
		
	#Dialogic.VAR.OPINIONS.set_variable("player_paper",0)
	Dialogic.VAR.set("player_paper",0)
