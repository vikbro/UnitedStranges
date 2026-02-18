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
	DialogicManager._update_dialogic_allegience()
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
	# Load kingdoms from resources
	#kingdoms[KingdomStats.Type.PAPER] = load("res://Data/Resources/paper_kingdom.tres")
	#kingdoms[KingdomStats.Type.CAT] = load("res://Data/Resources/cat_kingdom.tres")
	#kingdoms[KingdomStats.Type.MOON] = load("res://Data/Resources/moon_kingdom.tres")
	pass

## Get all kingdoms (exclude PLAYER type)
func get_all_kingdoms() -> Array[KingdomStats]:
	return kingdoms.values()



## Modify a kingdom's opinion of another entity
## opinion_change can be positive (increase) or negative (decrease)
#func modify_opinion(from_kingdom: int, of_kingdom: int, opinion_change: int) -> void:
	#if not kingdoms.has(from_kingdom):
		#return
	#
	#var kingdom = kingdoms[from_kingdom]
	#var current_opinion = kingdom.opinions.get(of_kingdom, 0)
	#var new_opinion = clamp(current_opinion + opinion_change, -100, 100)
	#
	#kingdom.opinions[of_kingdom] = new_opinion
	#opinions_dirty = true
	#
	#print("%s's opinion of %s changed by %d (now %d)" % [
		#_get_type_name(from_kingdom),
		#_get_type_name(of_kingdom),
		#opinion_change,
		#new_opinion
	#])


## Get direct opinion (before transitive calculation)
func get_direct_opinion(from_kingdom: int, of_kingdom: int) -> int:
	if not kingdoms.has(from_kingdom):
		return 0
	return kingdoms[from_kingdom].opinions.get(of_kingdom, 0)


## Get calculated opinion including transitive relationships
## This factors in the opinions of friends/enemies
#func get_calculated_opinion(from_kingdom: int, of_kingdom: int) -> int:
	#var cache_key = "%d_%d" % [from_kingdom, of_kingdom]
	#
	#if not opinions_dirty and cache_key in cached_opinions:
		#return cached_opinions[cache_key]
	#
	## Direct opinion is baseline
	#var direct = get_direct_opinion(from_kingdom, of_kingdom)
	#if direct == 0:
		#direct = 0  # Neutral
	#
	#var transitive_influence = 0
	#
	## Look at all kingdoms' opinions
	#for middleman_type in [KingdomStats.Type.PAPER, KingdomStats.Type.CAT, KingdomStats.Type.MOON]:
		#if middleman_type == from_kingdom or middleman_type == of_kingdom:
			#continue
		#
		## How does 'from_kingdom' feel about middleman?
		#var from_feels_about_middleman = get_direct_opinion(from_kingdom, middleman_type)
		#
		## How does middleman feel about 'of_kingdom'?
		#var middleman_feels_about_target = get_direct_opinion(middleman_type, of_kingdom)
		#
		## Apply transitive logic: multiply the relationships
		## Friend (positive) of Friend (positive) = positive influence on target
		## Friend (positive) of Enemy (negative) = negative influence on target
		#var influence = (from_feels_about_middleman * middleman_feels_about_target) / 100
		#transitive_influence += influence
	#
	#var final_opinion = clamp(direct + transitive_influence, -100, 100)
	#cached_opinions[cache_key] = final_opinion
	#
	#return final_opinion


## Calculate all kingdoms' opinions after dialogue phase
## Call this after dialogues are done to update all relationships
#func calculate_all_opinions() -> void:
	#print("\n=== CALCULATING TRANSITIVE RELATIONSHIPS ===\n")
	#
	#cached_opinions.clear()
	#opinions_dirty = false
	#
	## Display all calculated opinions
	#for kingdom in get_all_kingdoms():
		#print("%s opinion changes:" % _get_type_name(kingdom.kingdom_type))
		#
		#for other_type in [KingdomStats.Type.PAPER, KingdomStats.Type.CAT, KingdomStats.Type.MOON, KingdomStats.Type.PLAYER]:
			#if other_type == kingdom.kingdom_type:
				#continue
			#
			#var direct = get_direct_opinion(kingdom.kingdom_type, other_type)
			#var calculated = get_calculated_opinion(kingdom.kingdom_type, other_type)
			#
			#if calculated != direct:
				#print("  vs %s: %d → %d (transitive influence: %d)" % [
					#_get_type_name(other_type),
					#direct,
					#calculated,
					#calculated - direct
				#])
			#else:
				#print("  vs %s: %d" % [_get_type_name(other_type), direct])

## Get all kingdoms' current feelings toward target
## Useful for visualization
#func get_kingdom_opinions_of(target: KingdomStats.Type) -> Dictionary:
	#var result = {}
	#for kingdom in get_all_kingdoms():
		#result[_get_type_name(kingdom.kingdom_type)] = get_calculated_opinion(kingdom.kingdom_type, target)
	#return result

func _get_type_name(type_value: KingdomStats.Type) -> String:
	var type_names = {
		KingdomStats.Type.PAPER: "Paper",
		KingdomStats.Type.CAT: "Cat",
		KingdomStats.Type.MOON: "Moon",
		KingdomStats.Type.PLAYER: "Player"
	}
	return type_names.get(type_value, "Unknown")
