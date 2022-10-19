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
	# adds scancodes to the validator
	var test := owner.typing_test as TypingTest
	var validator = owner.validator
	validator.setup(test.scancodes)

	# ui setup
	prompt.setup(test.content)


	if test.mode == TypingTestModes.RACE:
		change_state("TypeRaceTestState")
		return
	elif test.mode == TypingTestModes.TIME_ATTACK:
		change_state("TimeAttackTestState")
		return
