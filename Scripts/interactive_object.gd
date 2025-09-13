class_name InteractiveObject
extends Area2D

var tween: Tween;
var shader_intensity: float = 0.0



func setup_highlight_intensity(intensity: float) -> void:
	shader_intensity = intensity
	$Sprite2D.material.set_shader_parameter("intensity", intensity)

func _on_mouse_entered() -> void:
	tween = create_tween()
	tween.tween_method(setup_highlight_intensity, shader_intensity, 1.0, 0.2)
	



func _on_mouse_exited() -> void:
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_method(setup_highlight_intensity, shader_intensity, 0.0, 0.2)
