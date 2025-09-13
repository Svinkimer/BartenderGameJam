extends Node2D


func _ready() -> void:
	GameState.alien_spawning_point_position = $AlienSpawningPoint.global_position
