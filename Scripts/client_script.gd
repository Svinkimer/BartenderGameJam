class_name Client
extends Sprite2D

const ALIEN_MOVEMENT_SLOWNESS: float = 2.0
const ALIEN_WAITING_TIME: float = 10

var temper_tween: Tween;
var position_tween: Tween;
var starting_position: Vector2
var cur_preset: AlienPreset
var is_waiting := false

func initiate(preset: AlienPreset):
	texture = preset.texture
	$Label.text = preset.name
	$Label.add_theme_color_override("font_color", preset.namecolor)
	cur_preset = preset

func _ready() -> void:
	starting_position = position
	enter_scene()

func enter_scene():
	if position_tween:
		print("ERROR: position_tween exists, when enter_scene is called")
	position_tween = create_tween()
	position_tween.tween_property(self, 'position', position + Vector2(500.0, 0.0), ALIEN_MOVEMENT_SLOWNESS).set_ease(Tween.EASE_IN_OUT)
	
	await position_tween.finished
	place_order()
	position_tween.kill()

func leave_scene():
	is_waiting = false
	
	if position_tween:
		position_tween.kill()
	position_tween = create_tween()
	position_tween.tween_property(self, 'position', starting_position, ALIEN_MOVEMENT_SLOWNESS).set_ease(Tween.EASE_IN_OUT)
	
	#await get_tree().create_timer(0.75).timeout
	#GameState.try_to_spawn_next_client()
	
	await position_tween.finished
	GameState.try_to_spawn_next_client()
	#queue_free()


func update_temper_display( progress_val: float):
	$ProgressBar.value = progress_val


func place_order():
	GameState.pick_cocktail()
	# say("Hey, I want '" + GameState.ordered_cocktail.name + "'", 1.5)
	var greet = cur_preset.greeting_line[randi() % cur_preset.greeting_line.size()]
	say(greet + GameState.ordered_cocktail.name + "'", 2)
	GameState.current_client = self
	is_waiting = true
	start_temper_timer()
	

func start_temper_timer():
	if temper_tween:
		temper_tween.kill()
	temper_tween = create_tween()
	temper_tween.tween_method(update_temper_display, 0.0, 100.0, ALIEN_WAITING_TIME);
	temper_tween.finished.connect(temper_over)

func eat_a_dumpling():
	update_temper_display(0)
	
	if temper_tween:
		temper_tween.kill()
		temper_tween.finished.disconnect(temper_over)
	
	start_temper_timer()
	print("timer reset")

signal client_unhappy

func temper_over():
	# say("Fuck you", 1.0)
	client_unhappy.emit()
	var reply = cur_preset.times_up_reply[randi() % cur_preset.times_up_reply.size()]
	say(reply, 2.0)
	leave_scene()

func drink_wrong_order():
	client_unhappy.emit()
	temper_tween.kill()
	var reply = cur_preset.wrong_drink_reply[randi() % cur_preset.wrong_drink_reply.size()]
	say(reply, 2.0)
	leave_scene()
	
func drink_right_order():
	temper_tween.kill()
	# say("Thank you, sunshine!", 1.0)
	var reply = cur_preset.right_drink_reply[randi() % cur_preset.right_drink_reply.size()]
	say(GameState.ordered_cocktail.client_line + " " + reply, 2.0)
	leave_scene()

func say(replic: String, time: float):
	$SpeechBubble.show()
	$SpeechBubble/Label.text = replic
	var timer = get_tree().create_timer(time)
	
	await timer.timeout
	$SpeechBubble.hide()

func get_waiting_state():
	return is_waiting
