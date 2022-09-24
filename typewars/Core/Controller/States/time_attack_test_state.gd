class_name TimeAttackTestState
extends BaseTypingTestState

const DEFAULT_TIMEOUT: int = 5
var timer: Timer


func enter() -> void:
	timer = Timer.new()
	add_child(timer)
	.enter()


func connect_signals() -> void:
	.connect_signals()
	timer.connect("timeout", self, "on_test_finished")


func on_test_started() -> void:
	timer.start(DEFAULT_TIMEOUT)


func on_test_finished() -> void:
	var results := owner.typing_test.results as TypingTestResults
	results.time = DEFAULT_TIMEOUT
	change_state("EndTestState")


func exit() -> void:
    .exit()
    timer.queue_free()
