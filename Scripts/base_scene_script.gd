extends Node2D


func _ready() -> void:
	GameState.alien_spawning_point_position = $AlienSpawningPoint.global_position
	GameState.ordered_cocktail_label = $OrderedCocktailLabel
	GameState.mixed_cocktail_label = $MixedCocktailLabel
