extends InteractiveObject

@export var topping: ToppingPreset

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if (event is InputEventMouseButton and event.pressed):
		print("Launching function `add_topping...` ", topping.name)
		GameState.add_topping_to_cocktail(topping)
