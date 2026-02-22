extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var texture_rect: TextureRect = $TextureRect
@onready var color_rect: ColorRect = $ColorRect

@export var wait_time: float = .5

func fade_to_scene(scene_path: String) -> void:
	visible = true
	animation_player.play("fade_to_black")
	await animation_player.animation_finished

	get_tree().change_scene_to_file(scene_path)
	await get_tree().create_timer(wait_time).timeout

	animation_player.play_backwards("fade_to_black")
	await animation_player.animation_finished
	visible = false
	
#To top-down
func dissolve_to_level(strategy_path: String, level_scene: PackedScene, transition_texture: Texture2D, level_num: int) -> void:
	visible = true
	texture_rect.texture = transition_texture
	texture_rect.visible = transition_texture != null

	animation_player.play_backwards("dissolve")
	await animation_player.animation_finished

	var strategy_scene = load(strategy_path).instantiate()
	var level = level_scene.instantiate()
	strategy_scene.called_from_level = level_num
	strategy_scene.add_child(level)
	get_tree().change_scene_to_node(strategy_scene)

	await get_tree().create_timer(wait_time).timeout
	animation_player.play("dissolve")
	await animation_player.animation_finished
	visible = false

#To Strategy_scene
func fade_to_level(strategy_path: String, level_path: String,level_num: int) -> void:
	visible = true
	animation_player.play("fade_to_black")
	await animation_player.animation_finished

	# Load and instantiate the strategy layout
	var strategy_scene = load(strategy_path).instantiate()
	strategy_scene.current_level = level_num

	# Load and instantiate the level tile
	var level_scene = load(level_path).instantiate()

	# Add the level as a child of the Tile node inside strategy
	#var tile_node = strategy_scene.get_node("Tile")
	strategy_scene.add_child(level_scene)

	get_tree().change_scene_to_node(strategy_scene)

	await get_tree().create_timer(wait_time).timeout
	animation_player.play_backwards("fade_to_black")
	await animation_player.animation_finished
	visible = false
	Events.transition_load.emit()
	return
