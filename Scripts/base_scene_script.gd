extends Node2D


func _ready() -> void:
	GameState.alien_spawning_point_position = $AlienSpawningPoint.global_position
	GameState.ordered_cocktail_label = $OrderedCocktailLabel
	GameState.mixed_cocktail_label = $MixedCocktailLabel

func _on_quit_pressed() -> void:
	MouseClick.play()
	
	# to test the ending screens
	#GameState.ending = 3
	#GameState.end_game()
	
	await get_tree().create_timer(0.5).timeout
	get_tree().quit()
