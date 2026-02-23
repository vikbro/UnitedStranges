extends TileMapLayer
class_name PlayArea

@export var kingdom_grid: KingdomGrid
var bounds: Rect2i
@export var current_kingdoms: Dictionary[Vector2i, KingdomStats]
@export var debug: bool = true

var _selected_tile: Vector2i = Vector2i(-9999, -9999)

func _ready() -> void:
	#_load_kingdom_data()
	Events.enter_level.connect(_load_kingdom_data)
	Events.exit_level.connect(_unload_data)
	#bounds = Rect2i(Vector2.ZERO, kingdom_grid.size)
	#for cell: Vector2i in get_used_cells():
		#var data = get_cell_tile_data(cell)
		#if data != null:
			#var kingdom_data = data.get_custom_data("kingdom_data")
			#add_kingdom(cell, kingdom_data)

	pass
	pass

func _load_kingdom_data() -> void:
	bounds = Rect2i(Vector2.ZERO, kingdom_grid.size)
	for cell: Vector2i in get_used_cells():
		var data = get_cell_tile_data(cell)
		if data != null:
			var kingdom_data = data.get_custom_data("kingdom_data")
			add_kingdom(cell, kingdom_data)

func _unload_data() -> void:
	DiplomacyManager.clear_kingdoms()
	
func add_kingdom(tile: Vector2i, kingdom: KingdomStats) -> void:
	current_kingdoms[tile] = kingdom
	DiplomacyManager.insert_kingdom(kingdom)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var hovered := get_hovered_tile()
		if current_kingdoms.has(hovered) and is_tile_in_bounds(hovered):
			if _selected_tile == hovered:
				# Clicking the same tile deselects
				_selected_tile = Vector2i(-9999, -9999)
				Events.kingdom_deselected.emit()
				Events.hide_kingdom_info.emit()
				Events.play_splash.emit(get_global_from_tile(get_hovered_tile()),Color.DARK_RED)
				AudioManager.zoom_out.play()
			else:
				_selected_tile = hovered
				Events.kingdom_selected.emit(get_global_from_tile(hovered))
				Events.show_kingdom_info.emit(current_kingdoms[_selected_tile])
				Events.play_splash.emit(get_global_from_tile(get_hovered_tile()),Color.DARK_RED)
				AudioManager.zoom_in.play()
		else:
			# Clicked empty tile — deselect
			if _selected_tile != Vector2i(-9999, -9999):
				_selected_tile = Vector2i(-9999, -9999)
				Events.kingdom_deselected.emit()
				Events.hide_kingdom_info.emit()
				AudioManager.zoom_out.play()
				#Events.play_splash.emit(get_global_from_tile(get_hovered_tile()),Color.DARK_RED)

func _process(_delta: float) -> void:
	if debug:
		
		%Label.text = str(get_local_mouse_position())
		%Label2.text = str(get_global_mouse_position())
		%Label3.text = str(get_tile_from_global(get_global_mouse_position()))
		%Label4.text = str(get_hovered_tile())
		%Label5.text = str(is_tile_in_bounds(get_hovered_tile()))
		%Label6.text = str(get_global_from_tile(get_hovered_tile()))
		
		if current_kingdoms.has(get_hovered_tile()):
			#$"../../CanvasLayer/HBoxContainer/VBoxContainer2/Label7"
			%Label7.text = str(current_kingdoms[get_hovered_tile()])

func get_tile_from_global(global: Vector2) -> Vector2i:
	return local_to_map(to_local(global))
func get_global_from_tile(tile: Vector2i) -> Vector2:
	return to_global(map_to_local(tile))
func get_hovered_tile() -> Vector2i:
	return local_to_map(get_local_mouse_position())
func is_tile_in_bounds(tile: Vector2i) -> bool:
	return bounds.has_point(tile)
