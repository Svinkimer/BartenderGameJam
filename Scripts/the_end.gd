extends Control

var ending = 0

func _ready() -> void:
	ending = GameState.get_ending()
	print(str(ending))
	
	match ending:
		0:
			$Label.text = "You won! Congratulations!"
			$Prize.visible = true
		1:
			$Label.text = "You poisoned a client!\nGalactic police are on their way."
			$Poison.visible = true
		2:
			$Label.text = "KABO-O-O-OM!\nClient's drink suddenly exploded!"
			$Exploison.visible = true
		3:
			$Label.text = "It looks like someone didn't pay their taxes...\nSee ya in court"
			$Handcuffs.visible = true
		4:
			$Label.text = "Clients were not satisfied with the quality\nof your service. Your blood and eyes\nere now theirs to use."
			$Handcuffs.visible = true


func _on_quit_pressed() -> void:
	MouseClick.play()
	await get_tree().create_timer(0.5).timeout
	get_tree().quit()
