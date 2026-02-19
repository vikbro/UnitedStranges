extends MarginContainer

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

@onready var kingdom_name: Label = $Panel/VBoxContainer/MarginContainer2/KingdomName
@onready var kingdom_background: TextureRect = $Panel/VBoxContainer/MarginContainer/Panel/MarginContainer/KingdomBackground
@onready var kingdom_banner: TextureRect = $Panel/VBoxContainer/HBoxContainer/MarginContainer/KingdomBanner
@onready var kingdom_description: Label = $Panel/VBoxContainer/HBoxContainer/MarginContainer2/KingdomDescription
@onready var opinion_lbl: Label = $Panel/VBoxContainer/HBoxContainer2/MarginContainer2/OpinionLbl

func _ready() -> void:
	Events.show_kingdom_info.connect(_load_kingdom_info)
	Events.hide_kingdom_info.connect(_hide_info)

func _load_kingdom_info(kingdom: KingdomStats) -> void:
	#kingdom_name = kingdom
	kingdom_background.texture = kingdom.background_img
	#kingdom_banner
	#kingdom_description
	if !kingdom.opinions.has(KingdomStats.Type.PLAYER):
		opinion_lbl.text = "0"
	elif kingdom.opinions[KingdomStats.Type.PLAYER] > 0:
		opinion_lbl.text = "+" + str(kingdom.opinions[KingdomStats.Type.PLAYER])
	else:
		opinion_lbl.text = "+" + str(kingdom.opinions[KingdomStats.Type.PLAYER])
		
	show_info()

func show_info() -> void:
	animation_player.play("show_kingdom_info")

func _hide_info() -> void:
	animation_player.play("hide_kingdom_info")
	
