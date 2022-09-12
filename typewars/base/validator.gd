class_name Validator
extends Node

signal word_passed
signal wrong_letter_input
signal correct_letter_input

var _scancodes: Array
var _index: int
var _errors: int


func _init(codes: Array):
	_scancodes = codes
	_index = 0
	_errors = 0


func validate(code: int) -> void:
	if !has_scancodes() || _index >= _scancodes.size():
		return

	if code != _scancodes[_index]:
		emit_signal("wrong_letter_input")
		_errors += 1
		print("Error: " + str(_errors))

	emit_signal("correct_letter_input")

	if _scancodes[_index] == KEY_SPACE:
		emit_signal("word_passed")

	_index += 1


func has_scancodes() -> bool:
	return (_scancodes == null) || _scancodes.empty()
