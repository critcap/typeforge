class_name SetupTestState
extends State

const DEFAULT_MODE = TypingTest.RACE

var prompt


func enter() -> void:
	.enter()
	prompt = owner.ui_prompt.prompt_display
	setup_test()
	yield(get_tree(), "idle_frame")
	owner.change_state("TypingTestState")


func setup_test() -> void:
	# setup test data
	var test_data := owner.selected_test as TypingTestData
	var test: = TypingTestFactory.assemble_test_from_data(test_data) as TypingTest
	test.mode = DEFAULT_MODE
	test.scancodes = ScancodeConverter.convert_text_to_scancodes(test.content)
	

	owner.typing_test = test
	
	# setup test classes
	var validator = Validator.new()
	owner.validator = validator
	validator.scancodes = test.scancodes

	test.results = TypingTestResults.new()
	validator.connect("correct_letter_input", test.results, "on_correct_letter_pressed")
	validator.connect("wrong_letter_input", test.results, "on_wrong_letter_pressed")
	validator.connect("word_passed", test.results, "on_word_passed")
	
	# ui setup
	prompt.setup(test.content)
	validator.connect("correct_letter_input", prompt, "_on_TypingTest_correct_letter_input")
	validator.connect("wrong_letter_input", prompt, "_on_TypingTest_wrong_letter_input")
	validator.connect("word_passed", prompt, "_on_TypingTest_word_passed")