class_name Validator
extends Node

signal started
signal finished

signal word_passed
signal wrong_letter_input(code)
signal correct_letter_input(code)


var scancodes: PoolIntArray
var _index: int = 0
var _errors: int = 0
var has_started: bool = false


func validate(event: InputEventKey) -> void:
	var code = get_scancode_from_event(event)
	
	if _index == 0 && !has_started:
		has_started = true
		emit_signal("started")

	if scancodes == null || scancodes.empty():
		return

	if code != scancodes[_index]:
		emit_signal("wrong_letter_input", code)
		_errors += 1
		print("Error: " + str(_errors))
		return

	emit_signal("correct_letter_input", code)
	if scancodes[_index] == KEY_SPACE:
		emit_signal("word_passed")
	_index += 1

	if _index >= scancodes.size():
		emit_signal("finished")


func get_scancode_from_event(event: InputEventKey) -> int:
	# TODO add cases for other OSes
	match OS.get_name():
		"Windows":
			return event.physical_scancode
	return event.scancode