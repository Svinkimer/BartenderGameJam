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

#region MANAGEMENT OF TOPPINGS
var cocktail_is_poisoned: bool = false

var toppings_in_cocktail: Dictionary[ToppingPreset, bool] = {
	preload("uid://dmn8rm05sjufe"): false,
	preload("uid://7gpxth7fjkll"): false,
}

func add_topping_to_cocktail(new_topping: ToppingPreset):
	if mixed_cocktail == null_cocktail:
		print("No cocktail to add topping at")
		return;
		
	if toppings_in_cocktail[new_topping]:
		print("You are repeating used topping")
		return;
	
	if new_topping.explodes_with == mixed_cocktail:
		ending_drink_exploded()
	
	if new_topping.poisons_with == mixed_cocktail:
		cocktail_is_poisoned = true
		
	
	
	toppings_in_cocktail[new_topping] = true;
	var new_label: Label = Label.new()
	new_label.text = new_topping.name
	
	var label_container: VBoxContainer = get_tree().root.get_node("BaseScene").get_node("%ToppingsList")
	
	label_container.add_child(new_label)
	
#endregion

#region MIXING COCKTAILS
var mixed_cocktail_label: Label
var null_cocktail: CocktailPreset = preload("uid://b14rl7maix6a3")
var mixed_cocktail: CocktailPreset = null_cocktail :
	set(new_mix):
		mixed_cocktail = new_mix
		mixed_cocktail_label.text = new_mix.name

func mix_cocktail() -> CocktailPreset:
	
	for cocktail in available_cocktails:
		var all_ingredients_present = true
		
		for ingredient: IngredientPreset in cocktail.ingredients:
			print("Ingredient: ", ingredient)
			if !drinks_in_mixer[ingredient]:
				print("No ingridient ", ingredient.name, " for cocktail ", cocktail.name)
				all_ingredients_present = false
				
				
		if all_ingredients_present:
			print("You are shaking cocktail:: ", cocktail.name)
			clear_drinks_in_mixer()
			mixed_cocktail = cocktail
	
	
	return mixed_cocktail



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




var alien_spawning_point_position: Vector2 = Vector2(-900, 70)
var alien_scene = preload("uid://dkc26c74e7e4b")
var alien_presets: Array[AlienPreset] = [
	preload("uid://b57ph1kf58bbg"),
	preload("uid://5allly8fun65"),
]

func _ready() -> void:
	print("Creating new alien")
	if get_tree().root.has_node("BaseScene"):
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

#region MAKING ORDER
var ordered_cocktail_label: Label
var ordered_cocktail: CocktailPreset = null_cocktail : 
	set(new_cocktail):
		ordered_cocktail = new_cocktail
		ordered_cocktail_label.text = new_cocktail.name
		

func pick_cocktail():
	var cocktail_idx = randi_range(0, len(available_cocktails)-1)
	ordered_cocktail = available_cocktails[cocktail_idx]

var current_client: Client


#endregion

#region SERVING ORDER
func serve_order()-> void:
	if mixed_cocktail == null_cocktail:
		return
	
	if cocktail_is_poisoned:
		cocktail_is_poisoned = false
		ending_poisoned_client()
	
	if ordered_cocktail == mixed_cocktail:
		current_client.drink_right_order()
		mixed_cocktail = null_cocktail
		print("You made correct cocktail!")

func give_tips():
	pass
	
#endregion

#region ENDINGS
func ending_win():
	print("Hurray! You won - 1000 space buckses earned")
	end_game()

func ending_poisoned_client():
	print("Oh, hell! You poisoned our client!!!")
	end_game()
	
func ending_drink_exploded():
	print("KABO-O-O-OM! Drink suddenly exploded!!!")
	end_game()

func ending_taxes_not_paied():
	print("Someone didn't pay their taxes, I see? Mua-ha-ha-ha!")
	end_game()
	
func ending_clients_unhappy():
	print("A crowd of unhappy clients came to kill you.")
	end_game()

func end_game():
	print("GAME OVER")
	
	await get_tree().create_timer(1.0).timeout
	get_tree().quit()
#endregion

#region UNHAPPY CLIENTS
var unhappy_clents_count: int = 0
#endregion
