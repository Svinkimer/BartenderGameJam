class_name CocktailGlass
extends InteractiveObject

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if (event is InputEventMouseButton and event.pressed):
		MouseClick.play()
		GameState.serve_order()
