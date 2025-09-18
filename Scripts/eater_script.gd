class_name Eater
extends InteractiveObject

var is_hidden: bool = true

func _ready() -> void:
	GameState.eater = self

func on_click():
	print("Eater swallows bad cocktail...")
	GameState.mixed_cocktail = GameState.null_cocktail
	GameState.clear_drinks_in_mixer()
	GameState.clear_toppings_in_cocktail()
	
func appear():
	is_hidden = false
	$AnimationPlayer.play("appear")
	monitoring = true

func disappear():
	is_hidden = true
	$AnimationPlayer.play_backwards("appear")
	monitoring = false
