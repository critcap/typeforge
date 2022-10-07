class_name Validator
extends Node

# region signals

# on the test has started
signal started
# when the test has finished
signal finished
# when the word is completed
signal word_passed

signal wrong_letter_input(code)
signal correct_letter_input(code)

# endregion

# region Properties
var index: int setget , get_index
var scancodes: PoolIntArray
var has_started: bool = false
var _index: int = 0

# endregion

# region Setters & Getters


func get_index() -> int:
	return _index


# endregion


func setup(codes: PoolIntArray) -> void:
	scancodes = codes
	_index = 0
	has_started = false


func validate(event: InputEventKey) -> void:
	if scancodes == null || scancodes.empty() || _index >= scancodes.size():
		return

	var code = event.scancode

	# workaround when using browser with different language
	# TODO layout setting
	if OS.get_name() == "HTML5" && code >= 200:
		code = event.physical_scancode

	# fires on first key input
	if _index == 0 && !has_started:
		has_started = true
		emit_signal("started")

	if code != scancodes[_index]:
		emit_signal("wrong_letter_input", code)
		_errors += 1
		return

	emit_signal("correct_letter_input", code)
	if scancodes[_index] == KEY_SPACE:
		emit_signal("word_passed")
	_index += 1

	if _index >= scancodes.size():
		emit_signal("finished")
