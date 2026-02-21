extends Node

signal level_win
signal level_lose

signal stop_highlight
signal start_highlight


signal kingdom_selected(global_pos: Vector2)  # camera zooms + locks here
signal kingdom_deselected                      # camera unlocks

signal show_kingdom_info(kingdom: KingdomStats)
signal hide_kingdom_info

signal play_splash(global_pos:Vector2,color:Color)
