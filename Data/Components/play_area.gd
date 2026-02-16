extends TileMapLayer
class_name PlayArea

@export var kingdom_grid: KingdomGrid

var bounds: Rect2i

@export var current_kingdoms: Dictionary[Vector2i,KingdomStats]

func _ready() -> void:
	bounds = Rect2i(Vector2.ZERO,kingdom_grid.size)
	for cell : Vector2i in get_used_cells():
		var data = get_cell_tile_data(cell)
		if data != null:
			var kingdom_data = data.get_custom_data("kingdom_data")
			add_kingdom(cell, kingdom_data)

func add_kingdom(tile: Vector2i, kingdom: KingdomStats ) -> void:
	current_kingdoms[tile] = kingdom
	#kingdom_grid_changed.emit()

func _process(delta: float) -> void:
	$"../CanvasLayer/HBoxContainer/VBoxContainer2/Label".text = str(get_local_mouse_position())
	$"../CanvasLayer/HBoxContainer/VBoxContainer2/Label2".text = str(get_global_mouse_position())
	$"../CanvasLayer/HBoxContainer/VBoxContainer2/Label3".text = str(get_tile_from_global(get_global_mouse_position()))
	$"../CanvasLayer/HBoxContainer/VBoxContainer2/Label4".text = str(get_hovered_tile())
	$"../CanvasLayer/HBoxContainer/VBoxContainer2/Label5".text = str(is_tile_in_bounds(get_hovered_tile()))
	$"../CanvasLayer/HBoxContainer/VBoxContainer2/Label6".text = str(get_global_from_tile(get_hovered_tile()))

func get_tile_from_global(global: Vector2) -> Vector2i:
	return local_to_map(to_local(global))

func get_global_from_tile(tile: Vector2i) -> Vector2:
	return to_global(map_to_local(tile))

func get_hovered_tile() -> Vector2i:
	return local_to_map(get_local_mouse_position())

func is_tile_in_bounds(tile: Vector2i) -> bool:
	return bounds.has_point(tile)
