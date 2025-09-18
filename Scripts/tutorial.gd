extends Control

@onready var rich_text_label: RichTextLabel = $RichTextLabel

var bar_menu: String

func _ready() -> void:
	create_bar_menu()

func create_bar_menu():
	# Cocktails 1 & 2
	bar_menu += "[table=4][cell=1][center][b]Кровавый Йода[/b][/center][/cell][cell=3][/cell]"
	bar_menu += "[cell=1][indent][indent][indent][center][b]Черный русский[/b][/center][/indent][/indent][/indent][/cell][cell=3][/cell]"
	bar_menu += "[cell][img=256x256]res://Assets/Graphics/Tutorial/cocktail1.png[/img][/cell]"
	bar_menu += "[cell][indent]• Кровь ОМЕЖки\n• Силушка богатырская\n[/indent][/cell]\n\n"
	bar_menu += "[cell][indent][indent][indent][center][img=256x256]res://Assets/Graphics/Tutorial/cocktail2.png[/img][/center][/indent][/indent][/indent][/cell]"
	bar_menu += "[cell][indent][indent]• Силушка богатырская\n• 50 abCent\n[/indent][/indent][/cell][/table]\n\n"
	
	# Cocktails 3 & 4
	bar_menu += "[table=4][cell][center][b]Копуляция на Татуине[/b][/center][/cell][cell][/cell]"
	bar_menu += "[cell][indent][indent][indent][center][b]Джедай-тоник[/b][/center][/indent][/indent][/indent][/cell][cell][/cell]"
	bar_menu += "[cell][img=256x256]res://Assets/Graphics/Tutorial/cocktail3.png[/img][/cell]"
	bar_menu += "[cell][indent]• Кровь ОМЕЖки\n• 50 abCent\n[/indent][/cell]\n\n"
	bar_menu += "[cell][indent][indent][indent][center][img=256x256]res://Assets/Graphics/Tutorial/cocktail4.png[/img][/center][/indent][/indent][/indent][/cell]"
	bar_menu += "[cell][indent][indent]• Силушка богатырская\n• Силушка богатырская\n[/indent][/indent][/cell][/table]\n\n"
	
	# Cocktails 5 & 6
	bar_menu += "[table=4][cell][center][b]Хиросима[/b][/center][/cell][cell][/cell]"
	bar_menu += "[cell][indent][indent][indent][center][b]Third sunrise[/b][/center][/indent][/indent][/indent][/cell][cell][/cell]"
	bar_menu += "[cell][img=256x256]res://Assets/Graphics/Tutorial/cocktail5.webp[/img][/cell]"
	bar_menu += "[cell][indent]• Силушка богатырская\n• Жижа\n[/indent][/cell]\n\n"
	bar_menu += "[cell][indent][indent][indent][center][img=256x256]res://Assets/Graphics/Tutorial/cocktail1.png[/img][/center][/indent][/indent][/indent][/cell]"
	bar_menu += "[cell][indent][indent]• Кровь ОМЕЖки\n• Жижа\n[/indent][/indent][/cell][/table]\n\n"
	
	# Cocktails 7 & 8
	bar_menu += "[table=4][cell][center][b]Проект Alien-хэттен[/b][/center][/cell][cell][/cell]"
	bar_menu += "[cell][indent][indent][indent][center][b]Виски-кола[/b][/center][/indent][/indent][/indent][/cell][cell][/cell]"
	bar_menu += "[cell][img=256x256]res://Assets/Graphics/Tutorial/cocktail2.png[/img][/cell]"
	bar_menu += "[cell][indent]• Кровь ОМЕЖки\n• Кровь ОМЕЖки\n[/indent][/cell]\n\n"
	bar_menu += "[cell][indent][indent][indent][center][img=256x256]res://Assets/Graphics/Tutorial/cocktail3.png[/img][/center][/indent][/indent][/indent][/cell]"
	bar_menu += "[cell][indent][indent]• 50 abCent\n• Жижа\n[/indent][/indent][/cell][/table]\n\n"
	
	bar_menu += "\n"
	
	# Toppings 1 & 2
	bar_menu += "[table=4][cell][center][b]Ягоды[/b][/center][/cell][cell][/cell]"
	bar_menu += "[cell][indent][indent][center][b]Глазки[/b][/center][/indent][/indent][/cell][cell][/cell]"
	bar_menu += "[cell][img=256x256]res://Assets/Graphics/Topping_1.png[/img][/cell]"
	bar_menu += "[cell][indent]НЕ смешивать с:\n• Хиросима\n• Черный русский\n[/indent][/cell]\n\n"
	bar_menu += "[cell][indent][indent][center][img=256x256]res://Assets/Graphics/Topping_2.png[/img][/center][/indent][/indent][/cell]"
	bar_menu += "[cell][indent][indent]НЕ смешивать с:\n• Копуляция на Татуине\n• Third sunrise\n[/indent][/indent][/cell][/table]\n\n"
	
	bar_menu += "[font_size=10]Make sure to pay your taxes by pressing 'N' before serving your every 10th customer.[/font_size]\n"
	
	rich_text_label.bbcode_text = bar_menu


func _on_button_pressed() -> void:
	MouseClick.play()
	
	if get_tree().root.has_node("BaseScene"):
		var overlay_scene = get_node("/root/Tutorial")
		if overlay_scene:
			overlay_scene.queue_free()
		
		get_tree().root.get_node("BaseScene").process_mode = Node.PROCESS_MODE_INHERIT
	else:
		get_tree().change_scene_to_file("uid://crvo564wxm88r") #main_menu.tscn
