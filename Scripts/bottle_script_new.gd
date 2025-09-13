class_name Bottle
extends InteractiveObject

@export var key: StringName 
@export var drink: IngredientPreset



func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if (event is InputEventMouseButton and event.pressed):
		print("Bottle " + drink.name + " was used.")
		GameState.add_drink_in_mixer(drink)
