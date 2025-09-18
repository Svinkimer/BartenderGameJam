class_name Bottle
extends InteractiveObject

@export var drink: IngredientPreset

func on_click():
	print("Bottle " + drink.name + " was used.")
	GameState.add_drink_in_mixer(drink)
