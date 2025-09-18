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
		print("No cocktail to add topping to")
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

var waiting_for_shaker := false
var current_cocktail: CocktailPreset

func mix_cocktail() -> CocktailPreset:
	
	for cocktail in available_cocktails:
		var all_ingredients_present = true
		
		for ingredient: IngredientPreset in cocktail.ingredients:
			print("Ingredient: ", ingredient)
			if !drinks_in_mixer[ingredient]:
				print("No ingridient ", ingredient.name, " for cocktail ", cocktail.name)
				all_ingredients_present = false
				
				
		if all_ingredients_present:
			current_cocktail = cocktail
			waiting_for_shaker = true
			
			get_tree().root.get_node("BaseScene/Shaker").visible = false
			
			var shaker_scene = load("uid://cj6012mk42p4q") #shaker.tscn
			var shaker = shaker_scene.instantiate()
			get_tree().root.add_child(shaker)
			
			shaker.connect("is_mixed", _on_shaker_mixed)
			get_tree().root.get_node("BaseScene").process_mode = Node.PROCESS_MODE_DISABLED
			
			print("You are shaking a cocktail: ", cocktail.name)
			clear_drinks_in_mixer()
	
	return mixed_cocktail

func _on_shaker_mixed():
	if waiting_for_shaker and current_cocktail:
		mixed_cocktail = current_cocktail
		
		waiting_for_shaker = false
		current_cocktail = null

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
	preload("uid://ddy1ootv74mt6")
]

var last_preset_id: int = -1

func _ready() -> void:
	get_tree().connect("tree_changed", _on_tree_changed)

func _on_tree_changed():
	if get_tree() == null or not is_instance_valid(get_tree()):
		return
	
	if get_tree().root == null:
		return
	
	if get_tree().root.has_node("BaseScene"):
		get_tree().disconnect("tree_changed", _on_tree_changed)
		print("Creating a new alien")
		create_client()

var signal_connected := false

func _process(_delta: float) -> void:
	
	if get_tree().root.has_node("BaseScene/Alien") and not signal_connected:
		get_tree().root.get_node("BaseScene/Other/Dumplings").connect("calm_the_client", _on_calm_the_client)
		signal_connected = true

func _on_calm_the_client():
	get_tree().root.get_node("BaseScene/Alien").eat_a_dumpling()

func try_to_spawn_next_client() -> void:
	var alien_node = get_tree().root.get_node("BaseScene/Alien")
	get_tree().root.get_node("BaseScene").remove_child(alien_node)
	alien_node.queue_free()
	
	create_client()
	# also here we'll add some checks "unhappy clients" ending condition

func create_client():
	client_vacant = true
	var new_alien: Client = alien_scene.instantiate()
	new_alien.global_position = alien_spawning_point_position
	
	var available_ids = []
	for i in alien_presets.size():
		if i != last_preset_id:
			available_ids.append(i)
			
	var id = available_ids[randi() % available_ids.size()]
	last_preset_id = id
	
	new_alien.initiate(alien_presets[id])
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

var client_vacant: bool

func serve_order()-> void:
	if mixed_cocktail == null_cocktail:
		return
	
	client_vacant = current_client.get_waiting_state()
	
	if not client_vacant:
		return
	
	if cocktail_is_poisoned:
		cocktail_is_poisoned = false
		ending_poisoned_client()
	
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
	else:
		current_client.drink_wrong_order()
		mixed_cocktail = null_cocktail
		return
	
	clear_toppings_in_cocktail()
	give_tips()

#endregion

#region TIPS
var earned_money: int = 0 : 
	set(value):
		earned_money = value
		get_base().get_node("%EarnedMoneyLabel").text = str(value)
		
		if value >= 900 and clients_served_since_tax_pay >= 10:
			ending_taxes_not_payed()
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
	print("Hurray! You won - 1000 space bucks earned")
	end_game()

func ending_poisoned_client():
	print("Oh, hell! You poisoned our client!!!")
	end_game()
	
func ending_drink_exploded():
	print("KABO-O-O-OM! Drink suddenly exploded!!!")
	end_game()

func ending_taxes_not_payed():
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

var tutorial: Control
var in_tutorial := false

func _input(event: InputEvent) -> void:
	if event is InputEventKey and not in_tutorial:
		if event.pressed and event.keycode == KEY_T:
			in_tutorial = true
			
			var tutorial_scene = load("uid://c4yc8r65ol6af")
			tutorial = tutorial_scene.instantiate()
			get_tree().root.add_child(tutorial)
			
			get_tree().root.get_node("BaseScene").process_mode = Node.PROCESS_MODE_DISABLED
			
		if event.pressed and event.keycode == KEY_N and earned_money >= 10 and clients_served_since_tax_pay > 0:
			print("taxes payed")
			clients_served_since_tax_pay = 0
			earned_money = earned_money * 0.9
			
