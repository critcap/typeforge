class_name SetupTestState
extends TestState

const DEFAULT_MODE = TypingTestModes.RACE

var prompt


func enter() -> void:
	.enter()
	prompt = owner.ui_prompt.prompt_display
	setup_test()


func setup_test() -> void:
	# setup test classes
	var test := owner.typing_test as TypingTest
	var validator = owner.validator
	validator.setup(test.scancodes)

	var collector = owner.stats_collector
	validator.connect("correct_letter_input", collector, "on_correct_letter_pressed")
	validator.connect("wrong_letter_input", collector, "on_wrong_letter_pressed")
	validator.connect("word_passed", collector, "on_word_passed")

	# ui setup
	prompt.setup(test.content)
	validator.connect("correct_letter_input", prompt, "_on_TypingTest_correct_letter_input")
	validator.connect("wrong_letter_input", prompt, "_on_TypingTest_wrong_letter_input")
	validator.connect("word_passed", prompt, "_on_TypingTest_word_passed")

	if test.mode == TypingTestModes.RACE:
		change_state("TypeRaceTestState")
		return
	elif test.mode == TypingTestModes.TIME_ATTACK:
		change_state("TimeAttackTestState")
		return
