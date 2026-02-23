extends Node
class_name AllegianceHighlighter

@export var enabled: bool = true : set = _set_enabled
@export var play_area: PlayArea
@export var highlight_layer: TileMapLayer
@export var ALLY_tile: Vector2i
@export var FRIEND_tile: Vector2i
@export var DISLIKE_tile: Vector2i
@export var ENEMY_tile: Vector2i

@onready var source_id := play_area.tile_set.get_source_id(0)

var selected_kingdom: KingdomStats : set = _set_selected_kingdom
var _last_hovered_tile: Vector2i = Vector2i(-9999, -9999)

func _ready() -> void:
	Events.stop_highlight.connect(_set_enabled.bind(false))
	Events.start_highlight.connect(_set_enabled.bind(true))

func _process(_delta: float) -> void:
	if not enabled:
		highlight_layer.clear()
		_last_hovered_tile = Vector2i(-9999, -9999)  # reset here too
		return
	
	var hovered_tile := play_area.get_hovered_tile()
	if not play_area.is_tile_in_bounds(hovered_tile):
		highlight_layer.clear()
		_last_hovered_tile = Vector2i(-9999, -9999)
		return
	
	var hovered_kingdom = play_area.current_kingdoms.get(hovered_tile)
	if not hovered_kingdom:
		highlight_layer.clear()
		_last_hovered_tile = Vector2i(-9999, -9999)  # reset on empty tiles too
		return
	
	if hovered_tile != _last_hovered_tile:
		_last_hovered_tile = hovered_tile
		AudioManager.hover.play()
		selected_kingdom = hovered_kingdom
		_update_all_tiles()

func _set_enabled(new_value: bool) -> void:
	enabled = new_value
	if not enabled and play_area:
		highlight_layer.clear()

func _set_selected_kingdom(new_kingdom: KingdomStats) -> void:
	selected_kingdom = new_kingdom

func _update_all_tiles() -> void:
	highlight_layer.clear()
	
	if not selected_kingdom:
		return
	
	for tile: Vector2i in play_area.current_kingdoms.keys():
		var tile_kingdom: KingdomStats = play_area.current_kingdoms[tile]
		if tile_kingdom.kingdom_type == selected_kingdom.kingdom_type:
			continue
		
		var tile_allegiance := selected_kingdom.get_allegience(tile_kingdom.kingdom_type)
		if tile_allegiance == KingdomStats.AllegienceType.ENEMY:
			highlight_layer.set_cell(tile, source_id, ENEMY_tile)
		elif tile_allegiance == KingdomStats.AllegienceType.DISLIKE:
			highlight_layer.set_cell(tile, source_id, DISLIKE_tile)
		if tile_allegiance == KingdomStats.AllegienceType.LIKE:
			highlight_layer.set_cell(tile, source_id, FRIEND_tile)
		elif tile_allegiance == KingdomStats.AllegienceType.ALLY:
			highlight_layer.set_cell(tile, source_id, ALLY_tile)
