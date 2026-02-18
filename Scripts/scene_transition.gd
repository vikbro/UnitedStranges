extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var texture_rect: TextureRect = $TextureRect
@export var wait_time: int = 2


func change_scene_to_node(target: Node,transition_texture:Texture = null) -> void:
	texture_rect.texture = transition_texture
	animation_player.play_backwards("dissolve")
	await animation_player.animation_finished
	#if target is DialoguePhaseLevel:
	get_tree().change_scene_to_node(target)
		
	await get_tree().create_timer(wait_time).timeout
	animation_player.play("dissolve")
	
