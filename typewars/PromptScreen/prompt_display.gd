extends Label

var test_content: Array
var index := 0

onready var progress_indicator := $ColorRect

func setup(content: Array):
	test_content = content
	text = get_current()


func _on_TypingTest_correct_letter_input():
	index += 1
	update_progress_indicator()


func _on_TypingTest_wrong_letter_input():
	update_progress_indicator(1)


func _on_TypingTest_word_passed():
	index = 0
	progress_indicator.rect_size.x = 0
	test_content.pop_front()
	text = get_current()


func get_current() -> String:
	if test_content.size() > 0:
		return test_content[0]
	return ""


func update_progress_indicator(offset: int = 0):
	if get_current().empty():
		progress_indicator.rect_size.x = 0
		return
	progress_indicator.rect_size.x = rect_size.x / get_current().length() * (index + offset)
