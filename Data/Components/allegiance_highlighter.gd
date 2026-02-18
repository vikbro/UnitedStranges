extends Node
class_name AllegianceHighlighter

@export var enabled: bool = true : set = _set_enabled
@export var play_area: PlayArea
@export var highlight_layer: TileMapLayer
@export var friend_tile: Vector2i      # Tile atlas coordinate for friendly highlight
@export var enemy_tile: Vector2i       # Tile atlas coordinate for enemy highlight

@onready var source_id := play_area.tile_set.get_source_id(0)

var selected_kingdom: KingdomStats : set = _set_selected_kingdom

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if not enabled:
		highlight_layer.clear()
		return
	
	var hovered_tile := play_area.get_hovered_tile()
	if not play_area.is_tile_in_bounds(hovered_tile):
		highlight_layer.clear()
		return
	
	var hovered_kingdom = play_area.current_kingdoms.get(hovered_tile)
	if not hovered_kingdom:
		highlight_layer.clear()
		return
	
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
	
	# Iterate over every tile that has a kingdom
	for tile: Vector2i in play_area.current_kingdoms.keys():
		var tile_kingdom: KingdomStats = play_area.current_kingdoms[tile]
		if tile_kingdom.kingdom_type == selected_kingdom.kingdom_type:
			continue
		var tile_allegience := selected_kingdom.get_allegience(tile_kingdom.kingdom_type)
		if tile_allegience == KingdomStats.AllegienceType.ENEMY || tile_allegience == KingdomStats.AllegienceType.DISLIKE :
			highlight_layer.set_cell(tile, source_id, enemy_tile)
		elif tile_allegience == KingdomStats.AllegienceType.LIKE || tile_allegience == KingdomStats.AllegienceType.ALLY :
			highlight_layer.set_cell(tile, source_id, friend_tile)
		#
		#if tile_kingdom.kingdom_type in selected_kingdom.likes:
			#highlight_layer.set_cell(tile, source_id, friend_tile)
		#elif tile_kingdom.kingdom_type in selected_kingdom.dislikes:
			#highlight_layer.set_cell(tile, source_id, enemy_tile)
		# If neutral, no highlight is placed (already cleared)
