class_name TypeRaceTestState
extends BaseTypingTestState

var stopwatch: Stopwatch


func enter() -> void:
	.enter()
	stopwatch = Stopwatch.new()
	add_child(stopwatch)


func on_test_started() -> void:
	stopwatch.start()


func on_test_finished() -> void:
	stopwatch.stop()
	var results := owner.typing_test.results as TypingTestResults
	results.time = stopwatch.get_time()
	change_state("EndTestState")


func exit() -> void:
	.exit()
	stopwatch.stop()
	stopwatch.queue_free()
