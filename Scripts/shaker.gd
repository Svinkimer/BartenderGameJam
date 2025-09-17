extends AnimatableBody2D

@onready var progress_bar: TextureProgressBar = $TextureProgressBar
@onready var arrow_shake_direction: Sprite2D = $ArrowShakeDirection

@onready var shaker_animation: AnimationPlayer = $Shaker/ShakerAnimation
@onready var arrow_animation: AnimationPlayer = $ArrowShakeDirection/ArrowAnimation

@export var increment := 0.15
@onready var arrow_timer: Timer = $ArrowShakeDirection/ArrowTimer
@onready var scene_timer: Timer = $SceneTimer

var is_pressed := false

enum SHAKE_DIRECTIONS {VERTICAL, HORIZONTAL}
var shake_direction = 0

signal is_mixed

func generate_shake_direction() -> void:
	var rand = randf()
	
	if (rand < 0.5):
		shake_direction = SHAKE_DIRECTIONS.VERTICAL
		
		if (arrow_shake_direction.rotation == 0):
			arrow_shake_direction.rotate(PI / 2)
	else:
		shake_direction = SHAKE_DIRECTIONS.HORIZONTAL
		
		if (arrow_shake_direction.rotation != 0):
			arrow_shake_direction.rotate(-PI / 2)

func _on_arrow_timer_timeout() -> void:
	generate_shake_direction()

func _ready():
	input_pickable = true

func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		is_pressed = true
		generate_shake_direction()
		arrow_shake_direction.visible = true
		arrow_animation.play("pulse")
		arrow_timer.wait_time = 3
		arrow_timer.start()
		
		scene_timer.wait_time = 10
		scene_timer.start()

func detect_shake(shake_direction, mouse_relative: Vector2):
	if (shake_direction == SHAKE_DIRECTIONS.VERTICAL):
		if (abs(mouse_relative.y) > 5 and abs(mouse_relative.x) < 10):
			progress_bar.value += increment
			shaker_animation.play("vertical_shake")
	else:
		if (abs(mouse_relative.x) > 5 and abs(mouse_relative.y) < 10):
			progress_bar.value += increment
			shaker_animation.play("horizontal_shake")

	if progress_bar.value == progress_bar.max_value:
		is_mixed.emit()
		arrow_animation.play("RESET")
		shaker_animation.play("RESET")
		arrow_shake_direction.visible = false
		
		quit_scene()

func _input(event: InputEvent) -> void:
	if is_pressed and event is InputEventMouseMotion:
		var mouse_relative = event.get_relative()
		detect_shake(shake_direction, mouse_relative)

func _on_scene_timer_timeout() -> void:
	quit_scene()
	
func quit_scene():
	var overlay_scene = get_node("/root/ShakerScene")
	if overlay_scene:
		overlay_scene.queue_free()
	
	get_tree().root.get_node("BaseScene").process_mode = Node.PROCESS_MODE_INHERIT
