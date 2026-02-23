extends CharacterBody2D
class_name Diplomat

@export var diplomat_type : KingdomStats.Type
@onready var input_panel: Panel = $InputPanel

func _ready() -> void:
	input_panel.hide()
	Dialogic.timeline_started.connect(_on_dialogue_started)
	Dialogic.timeline_ended.connect(_on_dialogue_ended)

func _on_dialogue_started() -> void:
	input_panel.hide()

func _on_dialogue_ended() -> void:
	input_panel.show()

func start_dialogue() -> void:
	var timeline = _get_timeline()
	if timeline:
		Dialogic.start(timeline)

func _get_timeline() -> String:
	match diplomat_type:
		KingdomStats.Type.SUN: return "sun_dialogue"
		KingdomStats.Type.VAMPIRE: return "vampire_dialogue"
		KingdomStats.Type.PAPER: return "paper_dialogue"
		KingdomStats.Type.WAREWOLF: return "werewolf_dialogue"
	return ""
