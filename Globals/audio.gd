extends Node

@onready var button_click: AudioStreamPlayer = $ButtonClick
@onready var zoom_in: AudioStreamPlayer = $ZoomIn
@onready var zoom_out: AudioStreamPlayer = $ZoomOut
@onready var hover: AudioStreamPlayer = $Hover
@onready var win: AudioStreamPlayer = $Win
@onready var lose: AudioStreamPlayer = $Lose
@onready var african_drums: AudioStreamPlayer = $AfricanDrums
@onready var intro: AudioStreamPlayer = $Intro
@onready var low_base: AudioStreamPlayer = $LowBase

func _ready() -> void:
	#Events.button_click.connect(button_click.play)
	#Events.zoom_in_click.connect(zoom_in.play)
	#Events.zoom_out_click.connect(zoom_out.play)
	#Events.hover_over.connect(hover.play)
	pass
	
