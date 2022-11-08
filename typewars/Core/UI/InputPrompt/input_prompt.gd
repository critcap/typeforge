class_name InputPrompt
extends Control

var content: Array

# ui elements
onready var ui_active: ActiveInputLabel = $CenterContainer/ActivePromptLabel
onready var ui_queue: InputPromptQueue = $InputPromptQueue
onready var ui_completed: InputPromptCompleted = $InputPromptCompleted


func bind_validator(validator: Validator):
	validator.connect("wrong_letter_input", self, "on_word_passed")

	# ui_active binds
	validator.connect("wrong_letter_input", ui_active, "_on_TypingTest_wrong_letter_input")
	validator.connect("correct_letter_input", ui_active, "_on_TypingTest_correct_letter_input")
	validator.connect("word_passed", ui_active, "_on_TypingTest_word_passed")
	pass


func setup_test(test: TypingTest):
	reset()
	content = Array(test.content)
	ui_active.text = content.pop_front()
	ui_queue.add_queue(content)


func on_word_passed():
	var finished: String = ui_active.text
	ui_active.text = get_next_word()
	ui_completed.push(finished)


func get_next_word():
	var next_word: String = ui_completed.pop()
	if next_word == null || next_word.empty():
		return
	return next_word


func reset():
	ui_active._on_TypingTest_word_passed()
	ui_queue.reset()
	ui_completed.reset()
