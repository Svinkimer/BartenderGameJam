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

func clear_toppings_in_cocktail():
	for key in toppings_in_cocktail.keys():
		toppings_in_cocktail[key] = false
		
	var label_container: VBoxContainer = get_tree().root.get_node("BaseScene").get_node("%ToppingsList")
	for child in label_container.get_children():
		child.queue_free()
	
#endregion

#region MIXING COCKTAILS
var mixed_cocktail_label: Label
var null_cocktail: CocktailPreset = preload("uid://b14rl7maix6a3")
var mixed_cocktail: CocktailPreset = null_cocktail :
	set(new_mix):
		mixed_cocktail = new_mix
		mixed_cocktail_label.text = new_mix.name

<<<<<<< Updated upstream
=======
var waiting_for_shaker := false
var current_cocktail: CocktailPreset

var eater: Eater;

>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
			mixed_cocktail = cocktail
	
=======
			eater.appear()
>>>>>>> Stashed changes
	
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
	await get_tree().create_timer(1.3).timeout
	
	if get_tree().root.has_node("BaseScene"):
		create_client()
	
	
func try_to_spawn_next_client() -> void:
	create_client()
	# also here we'll add some checks "unhappy clients" ending condition

func create_client():
<<<<<<< Updated upstream
=======
	print("Creating client...")
	client_vacant = true
>>>>>>> Stashed changes
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
		return
	
	if ordered_cocktail == mixed_cocktail:
		
		cocktail_cost = mixed_cocktail.cost
		#print("Serving cocktail: ", mixed_cocktail.name)
		#print("Base cocktail cost: ", mixed_cocktail.cost)
		for key: ToppingPreset in toppings_in_cocktail.keys():
			if toppings_in_cocktail[key]:
				cocktail_cost += key.cost
		#print("Total price is: ", cocktail_cost)
		
		current_client.drink_right_order()
		mixed_cocktail = null_cocktail
		#print("You made correct cocktail!")
	
	clear_toppings_in_cocktail()
	
	eater.disappear()
	give_tips()
	
<<<<<<< Updated upstream
=======

func _on_is_leaving():
	client_vacant = false

>>>>>>> Stashed changes
#endregion

#region TIPS
var earned_money: int = 0 : 
	set(value):
		earned_money = value
		get_base().get_node("%EarnedMoneyLabel").text = str(value)
		
		if value >= 900 and clients_served_since_tax_pay >= 10:
			ending_taxes_not_paied()
		if value >= 1000:
			ending_win()

var clients_served_since_tax_pay = 0



var tips_on_scene: Array[Tips] = [null, null, null, null]
var tips_scene = preload("uid://cci63fnvep627") # tips

var cocktail_cost: int = 0

func give_tips():
	var tips_instances_node: Node = get_tree().root.get_node("BaseScene").get_node("Tips")
	var no_empty_slots = true
	
	
	for i in range(len(tips_on_scene)):
		if tips_on_scene[i] == null:
			no_empty_slots = false
			var new_tip: Tips = tips_scene.instantiate()
			
			tips_instances_node.get_child(i).add_child(new_tip)
			new_tip.setup_reward(cocktail_cost)
			new_tip.idx = i
			
			tips_on_scene[i] = new_tip
			clients_served_since_tax_pay+=1
			break
			
	if no_empty_slots:
		tips_on_scene[0].add_reward(cocktail_cost)

func collect_tips(tips_node_index: int):
	var collected: Tips = tips_on_scene[tips_node_index]
	earned_money += collected.reward
	
	print(earned_money)
	tips_on_scene[tips_node_index] = null
	collected.queue_free()
	

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

#region TOOLS
func get_base() -> Node2D:
	return get_tree().root.get_node("BaseScene")
#endregion
