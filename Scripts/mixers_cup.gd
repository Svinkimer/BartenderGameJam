extends InteractiveObject


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if (event is InputEventMouseButton and event.pressed):
		print("Mixing cocktail")
		var cocktail = GameState.mix_cocktail()
		print(cocktail)
