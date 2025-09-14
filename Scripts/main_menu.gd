extends Control

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("uid://nexu324ps2np") #bar_scene.tscn


func _on_tutorial_pressed() -> void:
	get_tree().change_scene_to_file("uid://c4yc8r65ol6af") #tutorial.tscn


func _on_exit_pressed() -> void:
	get_tree().quit()
