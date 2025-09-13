extends Node


#region MANAGEMENT OF INGREDIENTS
const MAX_DRINKS_IN_MIX: int = 3

func count_drinks_in_mixer() -> int:
	var count := 0
	for value in drinks_in_mixer.values():
		if value:
			count += 1
	return count


var drinks_in_mixer: Dictionary[IngredientPreset, bool] = {
	preload("uid://buyaw0dauxdkx"): false, # gin
	preload("uid://bd7w6ca452nqg"): false, # wiskey
	preload("uid://bwown7dcpfvo6"): false # tonic
}



func add_drink_in_mixer(ingredient: IngredientPreset) -> bool:
	# mixer cup is full
	if count_drinks_in_mixer() >= MAX_DRINKS_IN_MIX:
		print("Mixer is full")
		return false;
		
	if drinks_in_mixer[ingredient]:
		print("This drink was already poured in shake")
		return true;
			
	
	drinks_in_mixer[ingredient] = true;
	
	print(drinks_in_mixer)
	
	return true

#endregion

#region MIXING COCKTAILS
var null_cocktail: CocktailPreset = preload("uid://b14rl7maix6a3")

func mix_cocktail() -> CocktailPreset:
	for cocktail in available_cocktails:
		var all_ingredients_present = false
		
		for ingredient: IngredientPreset in cocktail:
			if !drinks_in_mixer[ingredient]: 
				all_ingredients_present = false
				
				
		if all_ingredients_present:
			print("You are shaking cocktail:: ", cocktail.name)
			clear_drinks_in_mixer()
			return cocktail
			
		
	clear_drinks_in_mixer()
	return null_cocktail
	
	



func clear_drinks_in_mixer() -> void:
	for key in drinks_in_mixer.keys():
		drinks_in_mixer[key] = false

#endregion


#region SPAWN OF CLIENTS
var available_cocktails : Array[CocktailPreset] = [
	preload("uid://c681os1lt7nct"), # black-russian
	preload("uid://drtggy5hoev0d"), # gin-tonic
	preload("uid://b2vun11q07vnj"), # pina-colada
]


var ordered_cocktail: Resource

var alien_spawning_point_position: Vector2 = Vector2(-900, 70)
var alien_scene = preload("uid://dkc26c74e7e4b")
var alien_presets: Array[AlienPreset] = [
	preload("uid://b57ph1kf58bbg"),
	preload("uid://5allly8fun65"),
]






func _ready() -> void:
	print("Creating new alien")
	create_client()
	
	
func try_to_spawn_next_client() -> void:
	create_client()
	# also here we'll add some checks "unhappy clients" ending condition

func create_client():
	var new_alien: Client = alien_scene.instantiate()
	new_alien.global_position = alien_spawning_point_position
	new_alien.initiate(alien_presets[1])
	get_tree().root.get_node("BaseScene").add_child(new_alien)
	
#endregion
