class_name Eater
extends InteractiveObject

var is_hidden: bool = true


func _ready():
	GameState.eater = self

func on_click():
	print("Clicked eater...")
	GameState.mixed_cocktail = GameState.null_cocktail
	disappear()
	
func appear():
	$AnimationPlayer.play("appear")
	monitoring = true
	is_hidden = false
	
func disappear():
	$AnimationPlayer.play_backwards("appear")
	monitoring = true
	is_hidden = true
