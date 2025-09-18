extends Control

var ending = 0

func _ready() -> void:
	ending = GameState.get_ending()
	print(str(ending))
	
	match ending:
		0:
			$Label.text = "Вы победили! Поздравляем!"
			$Prize.visible = true
		1:
			$Label.text = "Вы отравили клиента!\nПолиция в пути."
			$Poison.visible = true
		2:
			$Label.text = "БУ-У-У-У-М!\nНапиток клиента внезапно взорвался!"
			$Exploison.visible = true
		3:
			$Label.text = "Кто-то решил уклониться от уплаты налогов...\nЖдите повестки в суд."
			$Handcuffs.visible = true
		4:
			$Label.text = "Клиенты остались недовольны Вашим сервисом\nВас пустили на ингредиенты для коктейлей."
			$Blood.visible = true


func _on_quit_pressed() -> void:
	MouseClick.play()
	await get_tree().create_timer(0.5).timeout
	get_tree().quit()
