class_name InteractiveObject
extends Area2D

var tween: Tween;
var shader_intensity: float = 0.0


func _ready():
	print("Interactive object ready for work")

func setup_highlight_intensity(intensity: float) -> void:
	shader_intensity = intensity
	$Sprite2D.material.set_shader_parameter("intensity", intensity)

func _on_mouse_entered() -> void:
	print("Mouse entered interactive object!")
	
	tween = create_tween()
	tween.tween_method(setup_highlight_intensity, shader_intensity, 1.0, 0.2)
	



func _on_mouse_exited() -> void:
	print("Mouse entered interactive object!")
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_method(setup_highlight_intensity, shader_intensity, 0.0, 0.2)
	print("Mouse exited interactive object!")
	pass # Replace with function body.
