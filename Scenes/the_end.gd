extends Control

func _ready() -> void:
	$Label.text = "You lost!"

func _on_quit_pressed() -> void:
	MouseClick.play()
	await get_tree().create_timer(0.5).timeout
	get_tree().quit()
