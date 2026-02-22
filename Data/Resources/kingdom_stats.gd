extends Resource
class_name KingdomStats

const MIN_OP = -100
const MAX_OP = 100
const INFLUENCE_FACTOR := 0.01

# Can youse curve to choose this
const ENEMY_THRESHOLD :int = -75
const DISLIKE_THRESHOLD :int = -10
const LIKE_THRESHOLD :int = 10
const ALLY_THRESHOLD :int = 75

enum AllegienceType {ENEMY,DISLIKE,NEUTRAL,LIKE,ALLY}
enum Type {PLAYER,PAPER,SUN,ICE,VAMPIRE,WAREWOLF} #WAREWOLF


# Opinion ranges from -100 (enemy) to 100 (ally)
# Dictionary keys match Type enum values
@export var opinions : Dictionary[Type, int] = {}

@export var kingdom_type : Type
@export var diplomat_img : Texture2D
@export var background_img  : Texture2D
@export var description : String
@export var banner_img : Texture2D
@export var level_scene: PackedScene
#@export var

func create_instance() -> Resource:
	var instance: KingdomStats = self.duplicate()
	#instance.
	return instance

func get_type_to_string() -> String:
	var type_names : Dictionary[Type,String] = {
		Type.PLAYER: "Player",
		Type.PAPER: "Paper",
		Type.SUN: "SUN", 
		Type.ICE: "ICE",
		Type.VAMPIRE: "VAMPIRE",
		Type.WAREWOLF: "WAREWOLF"
	}
	
	return type_names.get(kingdom_type, "Unknown")

func _to_string() -> String:
	var type_names : Dictionary[Type,String] = {
		Type.PLAYER: "Player",
		Type.PAPER: "Paper",
		Type.SUN: "SUN", 
		Type.ICE: "ICE",
		Type.VAMPIRE: "VAMPIRE",
		Type.WAREWOLF: "WAREWOLF"
	}
	
	var type_name = type_names.get(kingdom_type, "Unknown")
	var opinions_str = ""
	
	for other_type in opinions.keys():
		var other_name = type_names.get(other_type, "Unknown")
		var opinion_value = opinions[other_type]
		opinions_str += "%s: %d; " % [other_name, opinion_value]
	
	return "KingdomStats(type=%s, opinions=[%s])" % [type_name, opinions_str.trim_suffix("; ")]

func get_allegience(kingdom: Type) -> AllegienceType:
	var value : int = opinions.get(kingdom,0)
	
	if value >= ALLY_THRESHOLD:
		return AllegienceType.ALLY
	elif value >= LIKE_THRESHOLD:
		return AllegienceType.LIKE
	elif value <= ENEMY_THRESHOLD:
		return AllegienceType.ENEMY
	elif value <= DISLIKE_THRESHOLD:
		return AllegienceType.DISLIKE
	else:
		return AllegienceType.NEUTRAL

func calculate_player_opinion(player_opinions: Dictionary[Type, int]) -> void:
	# Do not run for player kingdom itself
	if kingdom_type == Type.PLAYER:
		return
	
	var total_influence: float = 0.0
	var count: int = 0 #Used for normalization
	
	for other_kingdom : Type in player_opinions.keys():
		# Skip self and player entry
		if other_kingdom == kingdom_type or other_kingdom == Type.PLAYER:
			continue
		
		# Make sure both sides have data
		if not opinions.has(other_kingdom):
			continue
		
		var my_opinion: int = opinions[other_kingdom]
		var player_opinion: int = player_opinions[other_kingdom]
		
		# Core diplomacy rule
		var delta := my_opinion * player_opinion * INFLUENCE_FACTOR
		
		total_influence += delta
		count += 1 # Used for normalization
	
	# Optional normalization (HIGHLY recommended for balance)
	if count > 0:
		total_influence /= count
	
	# Apply change to my opinion of player
	#var base := opinions.get(Type.PLAYER)
	var base = opinions.get(Type.PLAYER,0)
	var new_value := clampi(roundi(base + total_influence), MIN_OP, MAX_OP)
	
	opinions[Type.PLAYER] = new_value
	#Events.play_splash.emit()


func modify_opinion(change_kingdom: Type, amount: int) -> void:
	var base = opinions.get(change_kingdom,0)
	var new_value := clampi(roundi(base + amount), MIN_OP, MAX_OP)
	
	opinions[change_kingdom] = new_value
	
