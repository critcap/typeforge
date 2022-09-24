class_name TypingTestResults
extends Reference

var wpm: float setget , get_wpm
var time: float

var _register := {}
var _words: int = 0
var _time_stamp


func get_wpm() -> float:
	time = 0.1 if time == 0 else time
	var minute: float = 60 / time
	return _words * minute


func on_correct_letter_pressed(code: int) -> void:
	if not _register.has(code):
		_register[code] = LetterStatistics.new(code)

	var letter := _register[code] as LetterStatistics
	letter.count += 1
	letter.correct_presses += 1
	letter.total_time += get_time_stamp()


func on_wrong_letter_pressed(code: int) -> void:
	if not _register.has(code):
		_register[code] = LetterStatistics.new(code)

	var letter := _register[code] as LetterStatistics
	letter.count += 1
	letter.false_presses += 1


func on_word_passed() -> void:
	_words += 1


func get_time_stamp(get_time_only: bool = false) -> float:
	if !_time_stamp:
		_time_stamp = OS.get_ticks_msec()
		return 0.0

	var stamp = OS.get_ticks_msec()
	var time_stamp = stamp - _time_stamp
	if !get_time_only:
		_time_stamp = stamp
	return time_stamp


class LetterStatistics:
	extends Reference
	var code: int
	var count := 0
	var total_time := 0.0

	var correct_presses := 0
	var false_presses := 0

	func _init(new_code: int):
		code = new_code
