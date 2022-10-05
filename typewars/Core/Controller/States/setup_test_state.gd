class_name SetupTestState
extends TestState

const DEFAULT_MODE = TypingTestModes.RACE

var prompt


func enter() -> void:
	.enter()
	prompt = owner.ui_prompt.prompt_display
	setup_test()


func setup_test() -> void:
	# setup test data
	var test_data := owner.selected_test as TypingTestData
	var combine = assemble_combined_test()
	var test := TypingTestFactory.assemble_test_from_data(test_data, combine) as TypingTest
	test.mode = DEFAULT_MODE
	test.scancodes = ScancodeConverter.convert_text_to_scancodes(test.content)

	owner.typing_test = test

	# setup test classes
	var validator = Validator.new()
	owner.validator = validator
	validator.scancodes = test.scancodes

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
	elif test.mmode == TypingTest.TIME_ATTACK:
		change_state("TimeAttackTestState")
		return


func assemble_combined_test() -> Array:
	var output = []
	if (
		owner.selected_test != null
		&& owner.selected_test.arguments.has("combine")
		&& !owner.selected_test.arguments["combine"].empty()
	):
		for i in owner.selected_test.arguments["combine"]:
			var test_data = owner.test_list[i].data if owner.test_list.has(i) else []
			output += test_data
	return output