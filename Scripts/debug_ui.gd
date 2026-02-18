extends VBoxContainer

var change_amount: int
var opinion_of: KingdomStats.Type
var opinion_about: KingdomStats.Type

@onready var text_edit: TextEdit = $HBoxContainer/TextEdit

func _on_text_edit_text_changed() -> void:
	change_amount = int(text_edit.text)
	print(change_amount)
	pass # Replace with function body.

func _on_opinion_of_item_selected(index: int) -> void:
	opinion_of = index
	pass # Replace with function body.

func _on_opinion_about_item_selected(index: int) -> void:
	opinion_about = index
	pass # Replace with function body.


func _on_submit_btn_pressed() -> void:
	DiplomacyManager.modify_opinion(opinion_of,opinion_about,change_amount)
	pass # Replace with function body.


func _on_diplomacy_button_pressed() -> void:
	DiplomacyManager._simulate_diplomacy()
	pass # Replace with function body.
