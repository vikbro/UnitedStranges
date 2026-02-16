extends Resource
class_name KingdomStats

enum Type {PAPER, CAT, MOON}

@export var kingdom_type : Type

@export var likes : Array[Type]
@export var dislikes : Array[Type]
@export var neutral : Array[Type]

@export var diplomat_img : Texture2D
@export var background_img  : Texture2D

func create_instance() -> Resource:
	var instance: KingdomStats = self.duplicate()
	#instance.
	return instance

func _to_string() -> String:
	var type_names = {
		Type.PAPER: "Paper",
		Type.CAT: "Cat", 
		Type.MOON: "Moon"
	}
	
	var type_name = type_names.get(kingdom_type, "Unknown")
	
	var likes_str = ", ".join(likes.map(func(t): return type_names.get(t, "Unknown")))
	var dislikes_str = ", ".join(dislikes.map(func(t): return type_names.get(t, "Unknown")))
	
	return "KingdomStats(type=%s, likes=[%s], dislikes=[%s])\n" % [type_name, likes_str, dislikes_str]
