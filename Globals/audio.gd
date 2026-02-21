extends Node

@onready var button_click: AudioStreamPlayer = $ButtonClick
@onready var zoom_in: AudioStreamPlayer = $ZoomIn
@onready var zoom_out: AudioStreamPlayer = $ZoomOut
@onready var hover: AudioStreamPlayer = $Hover

func _ready() -> void:
	#Events.button_click.connect(button_click.play)
	#Events.zoom_in_click.connect(zoom_in.play)
	#Events.zoom_out_click.connect(zoom_out.play)
	#Events.hover_over.connect(hover.play)
	pass
	
