extends AnimatableBody2D

@onready var progress_bar: TextureProgressBar = $TextureProgressBar
@onready var arrow_shake_direction: Sprite2D = $ArrowShakeDirection

@export var increment := 0.1
@onready var timer: Timer = $Timer

var is_pressed := false
var init_mouse_pos := Vector2.ZERO

enum SHAKE_DIRECTIONS {VERTICAL, HORIZONTAL}
var shake_direction = 0

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

func _on_timer_timeout() -> void:
	generate_shake_direction()

func _ready():
	input_pickable = true
	generate_shake_direction()

func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		is_pressed = true
		timer.start()
		timer.wait_time = 4
	
	if is_pressed and event is InputEventMouseMotion:
		var mouse_pos = event.position
		detect_shake(shake_direction, mouse_pos)

func detect_shake(shake_direction, mouse_pos):
	if (shake_direction == SHAKE_DIRECTIONS.VERTICAL):
		if (abs(mouse_pos.x - init_mouse_pos.x) < 20) and (abs(mouse_pos.y - init_mouse_pos.y) > 5):
			progress_bar.value += increment
			
			if progress_bar.value > progress_bar.max_value:
				progress_bar.value = progress_bar.max_value
				is_pressed = false
	else:
		if (abs(mouse_pos.y - init_mouse_pos.y) < 20) and (abs(mouse_pos.x - init_mouse_pos.x) > 5):
			progress_bar.value += increment
			
			if progress_bar.value > progress_bar.max_value:
				progress_bar.value = progress_bar.max_value
				is_pressed = false
	
	init_mouse_pos = mouse_pos
