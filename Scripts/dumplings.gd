class_name Dumplings
extends InteractiveObject

signal calm_the_client
var number_of_dumplings := 3

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		MouseClick.play()
		
		if number_of_dumplings > 0:
			print("Have a dumpling!")
			calm_the_client.emit()
			number_of_dumplings -= 1
