extends Node

signal test_started(text)
signal word_passed
signal wrong_letter_input
signal correct_letter_input

var has_started setget , _has_started
var errors: int = 0

var test_text: Array
var test_codes: Array

var test_index := 0
var text_index := 0

var timer: Stopwatch


func _ready():
	test_text = TextGenerator.generate_typing_string(40)
	test_codes = ScancodeConverter.convert_text_to_scancodes(test_text)
	timer = Stopwatch.new()
	add_child(timer)


func start_test() -> void:
	test_index = 0
	text_index = 0
	timer.start()
	emit_signal("test_started", test_text as Array)


func end_test() -> void:
	timer.stop()
	print(
		str("Test ended with " + str(errors) + " errors in " + str(timer.get_time()) + " seconds")
	)


func _has_started() -> bool:
	return timer.has_started()


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
		return
	if !(event is InputEventKey):
		return

	var key_event := event as InputEventKey
	if !key_event.pressed || key_event.echo:
		return

	if can_start(key_event):
		start_test()
		return

	if !self._has_started():
		return

	validate_input(key_event)

	if test_index >= test_codes.size():
		end_test()


func can_start(event: InputEventKey) -> bool:
	if self._has_started():
		return false
	# ? Keep on spacebar start?
	if event.scancode == KEY_SPACE:
		return true
	if event.physical_scancode == test_codes[0]:
		return true
	return false


func validate_input(key_event: InputEventKey) -> void:
	if key_event.physical_scancode == test_codes[test_index]:
		if test_index >= test_codes.size():
			end_test()
			return
		if test_codes[test_index] == KEY_SPACE:
			text_index += 1
			emit_signal("word_passed")
			test_index += 1
			return
		test_index += 1
		emit_signal("correct_letter_input")
	else:
		emit_signal("wrong_letter_input")
		errors += 1
		print("Error: " + str(errors))
