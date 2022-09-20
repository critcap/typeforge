class_name SetupTestState
extends State

var prompt


func enter() -> void:
	.enter()
	prompt = owner.prompt_display


func setup_test() -> void:
	# setup test data
	var test_data := owner.selected_test as TypingTestData
	var test = TypingTestFactory.assemble_test_from_data(test_data)
	test.scancodes = ScancodeConverter.convert_text_to_scancodes(test.content)
	# setup test classes
	owner.validator = Validator.new()
