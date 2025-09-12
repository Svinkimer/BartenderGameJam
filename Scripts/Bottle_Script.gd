extends Area2D

@export var key: StringName 

func _on_mouse_entered() -> void:
	
	print("Mouse entered bottle!")


func _on_mouse_exited() -> void:
	pass # Replace with function body.




func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if (event is InputEventMouseButton and event.pressed):
		print("Bottle " + key + " was used.")
		GameState.add_drink_in_mixer(key)
