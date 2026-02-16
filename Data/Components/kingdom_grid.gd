class_name KingdomGrid
extends Node2D

signal kingdom_grid_changed

const PAPER_KINGDOM = preload("uid://hq12i3pflt8v")

@export var size: Vector2i
@export var kingdom_tiles: TileMapLayer
@export var kingdoms: Dictionary[Vector2i,KingdomStats]


func _ready() -> void:
	for i in size.x:
		for j in size.y:
			kingdoms[Vector2i(i,j)] = null

	#play_area.get
	#add_kingdom(Vector2i(0,0),PAPER_KINGDOM.create_instance())
	#add_kingdom(Vector2i(0,1),PAPER_KINGDOM.create_instance())
	#print("(0,0) tile occupied: ", is_tile_occupied(Vector2i(0,0)))
	#print("is_grid_full: ", is_grid_full())
	##print("(0,0) tile occupied: ", is_tile_occupied(Vector2i(0,0)))
	#print("array of all kingdoms: ", get_all_kingdoms())

func add_kingdom(tile: Vector2i, kingdom: KingdomStats ) -> void:
	kingdoms[tile] = kingdom
	kingdom_grid_changed.emit()

func is_tile_occupied(tile: Vector2i) -> bool:
	return kingdoms[tile] != null

func is_grid_full() -> bool:
	return kingdoms.keys().all(is_tile_occupied)

#func get_first_empty_tile() -> Vector2i:
	

func get_all_kingdoms() -> Array[KingdomStats]:
	var kingdom_array: Array[KingdomStats] = []
	
	for kingdom: KingdomStats in kingdoms.values():
		if kingdom:
			kingdom_array.append(kingdom)
	return kingdom_array
