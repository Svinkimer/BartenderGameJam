extends Node2D

func _input(event):
	if event is InputEventMouseMotion:
		print(event.relative)
