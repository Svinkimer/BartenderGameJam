extends InteractiveObject




func on_click():
	print("Mixing cocktail")
	var cocktail = GameState.mix_cocktail()
	print(cocktail.name)
