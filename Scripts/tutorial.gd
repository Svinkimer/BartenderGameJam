extends Control

@onready var rich_text_label: RichTextLabel = $RichTextLabel

var bar_menu: String

func _ready() -> void:
	create_bar_menu()

func create_bar_menu():
	# Cocktails 1 & 2
	bar_menu += "[table=4][cell][center][b]Cocktail 1[/b][/center][/cell][cell][/cell]"
	bar_menu += "[cell][indent][indent][indent][center][b]Cocktail 2[/b][/center][/indent][/indent][/indent][/cell][cell][/cell]"
	bar_menu += "[cell][img=256x256]res://Assets/Graphics/Tutorial/cocktail1.png[/img][/cell]"
	bar_menu += "[cell][indent]• Ingredient 1\n• Ingredient 2\n[/indent][/cell]\n\n"
	bar_menu += "[cell][indent][indent][indent][center][img=256x256]res://Assets/Graphics/Tutorial/cocktail2.png[/img][/center][/indent][/indent][/indent][/cell]"
	bar_menu += "[cell][indent][indent]• Ingredient 1\n• Ingredient 2\n[/indent][/indent][/cell][/table]\n\n"
	
	# Cocktails 3 & 4
	bar_menu += "[table=4][cell][center][b]Cocktail 3[/b][/center][/cell][cell][/cell]"
	bar_menu += "[cell][indent][indent][indent][center][b]Cocktail 4[/b][/center][/indent][/indent][/indent][/cell][cell][/cell]"
	bar_menu += "[cell][img=256x256]res://Assets/Graphics/Tutorial/cocktail3.png[/img][/cell]"
	bar_menu += "[cell][indent]• Ingredient 1\n• Ingredient 2\n[/indent][/cell]\n\n"
	bar_menu += "[cell][indent][indent][indent][center][img=256x256]res://Assets/Graphics/Tutorial/cocktail4.png[/img][/center][/indent][/indent][/indent][/cell]"
	bar_menu += "[cell][indent][indent]• Ingredient 1\n• Ingredient 2\n[/indent][/indent][/cell][/table]\n\n"
	
	# Cocktails 5 & 6
	bar_menu += "[table=4][cell][center][b]Cocktail 5[/b][/center][/cell][cell][/cell]"
	bar_menu += "[cell][indent][indent][indent][center][b]Cocktail 6[/b][/center][/indent][/indent][/indent][/cell][cell][/cell]"
	bar_menu += "[cell][img=256x256]res://Assets/Graphics/Tutorial/cocktail5.webp[/img][/cell]"
	bar_menu += "[cell][indent]• Ingredient 1\n• Ingredient 2\n[/indent][/cell]\n\n"
	bar_menu += "[cell][indent][indent][indent][center][img=256x256]res://Assets/Graphics/Tutorial/cocktail1.png[/img][/center][/indent][/indent][/indent][/cell]"
	bar_menu += "[cell][indent][indent]• Ingredient 1\n• Ingredient 2\n[/indent][/indent][/cell][/table]\n\n"
	
	# Cocktails 7 & 8
	bar_menu += "[table=4][cell][center][b]Cocktail 7[/b][/center][/cell][cell][/cell]"
	bar_menu += "[cell][indent][indent][indent][center][b]Cocktail 8[/b][/center][/indent][/indent][/indent][/cell][cell][/cell]"
	bar_menu += "[cell][img=256x256]res://Assets/Graphics/Tutorial/cocktail2.png[/img][/cell]"
	bar_menu += "[cell][indent]• Ingredient 1\n• Ingredient 2\n[/indent][/cell]\n\n"
	bar_menu += "[cell][indent][indent][indent][center][img=256x256]res://Assets/Graphics/Tutorial/cocktail3.png[/img][/center][/indent][/indent][/indent][/cell]"
	bar_menu += "[cell][indent][indent]• Ingredient 1\n• Ingredient 2\n[/indent][/indent][/cell][/table]\n\n"
	
	rich_text_label.bbcode_text = bar_menu


func _on_button_pressed() -> void:
	if get_tree().root.has_node("BaseScene"):
		var overlay_scene = get_node("/root/Tutorial")
		if overlay_scene:
			overlay_scene.queue_free()
		
		get_tree().root.get_node("BaseScene").process_mode = Node.PROCESS_MODE_INHERIT
	else:
		get_tree().change_scene_to_file("uid://crvo564wxm88r") #main_menu.tscn
