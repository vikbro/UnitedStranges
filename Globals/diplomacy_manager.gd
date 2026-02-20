extends Node
## Manages all kingdoms and their opinions of each other
## Implements transitive relationship logic:
## - Friend of friend = friend (positive * positive)
## - Enemy of enemy = friend (negative * negative)  
## - Friend of enemy = enemy (positive * negative)
## - Enemy of friend = enemy (negative * positive)

# Dictionary to store kingdom instances by their Type
var kingdoms: Dictionary[KingdomStats.Type, KingdomStats]

# Store calculated opinions to avoid recalculating
#var cached_opinions: Dictionary = {}

# Track if opinions need recalculation
#var opinions_dirty: bool = true

func insert_kingdom(kingdom: KingdomStats) -> void:
	kingdoms[kingdom.kingdom_type] = kingdom
	
	pass

func clear_kingdoms() -> void:
	kingdoms.clear()

# Ensurea all tile kingdoms form opinion about the player
func simulate_diplomacy() -> void:
	for kingdom : KingdomStats in kingdoms.values():
		kingdom.calculate_player_opinion(kingdoms.get(KingdomStats.Type.PLAYER))
		
	pass
	
func _simulate_diplomacy() -> void:
	# Get the player kingdom
	var player_kingdom: KingdomStats = kingdoms.get(KingdomStats.Type.PLAYER)
	# Validate player exists
	if player_kingdom == null:
		printerr("Cannot simulate diplomacy: Player kingdom not found!")
		return
	# Update each non-player kingdom's opinion of the player
	for kingdom: KingdomStats in kingdoms.values():
		# Skip the player itself
		if kingdom.kingdom_type == KingdomStats.Type.PLAYER:
			continue
		
		# Pass the player's opinions dictionary
		kingdom.calculate_player_opinion(player_kingdom.opinions)
	DialogicManager.update_dialogic_allegience()
	#DialogicManager


func modify_opinion(opinon_of: KingdomStats.Type,opinion_about: KingdomStats.Type, amount: int) -> void:
	var kingdom_of : KingdomStats = kingdoms.get(opinon_of,0)
	
	kingdom_of.modify_opinion(opinion_about,amount)
	print("Opinion of %s about %s changed by %d (now %d)" % [
		_get_type_name(opinon_of),
		_get_type_name(opinion_about),
		amount,
		kingdom_of.opinions.get(opinion_about,0)
	])

## Check if all kingdoms are allied with the player
func check_win_condition() -> bool:
	for kingdom : KingdomStats in kingdoms.values():
		if kingdom.get_allegience(KingdomStats.Type.PLAYER) == KingdomStats.AllegienceType.ALLY:
			continue
		else:
			return false
	return true
	
	Events.level_win.emit()
	
## Check if all kingdoms are enemies with the player
func check_lose_condition() -> bool:
	for kingdom : KingdomStats in kingdoms.values():
		if kingdom.get_allegience(KingdomStats.Type.PLAYER) == KingdomStats.AllegienceType.ENEMY:
			continue
		else:
			return false
	return true
	
	Events.level_lose.emit()

func _ready() -> void:
	pass

## Get all kingdoms (exclude PLAYER type)
func get_all_kingdoms() -> Array[KingdomStats]:
	return kingdoms.values()

## Get direct opinion (before transitive calculation)
func get_direct_opinion(from_kingdom: int, of_kingdom: int) -> int:
	if not kingdoms.has(from_kingdom):
		return 0
	return kingdoms[from_kingdom].opinions.get(of_kingdom, 0)

func _get_type_name(type_value: KingdomStats.Type) -> String:
	var type_names = {
		KingdomStats.Type.PAPER: "Paper",
		KingdomStats.Type.SUN: "Sun",
		KingdomStats.Type.ICE: "Ice",
		KingdomStats.Type.PLAYER: "Player",
		KingdomStats.Type.VAMPIRE: "VAMPIRE"
	}
	return type_names.get(type_value, "Unknown")
