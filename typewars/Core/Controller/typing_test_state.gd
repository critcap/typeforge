class_name TypingTestState
extends State

var validator: Validator
var test: TypingTest

var timer


func enter() -> void:
	validator = owner.validator
	create_timer_from_mode(owner.typing_test.mode)
	owner.ui_prompt.visible = true
	.enter()


func connect_signals() -> void:
	validator.connect("started", self, "on_test_started")
	validator.connect("finished", self, "on_test_finished")

	if timer is Timer:
		timer.connect("timeout", self, "on_test_finished")


func unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		# TODO add abort
		return
	if !(event is InputEventKey):
		return

	var key_event := event as InputEventKey

	if OS.is_debug_build() && key_event.scancode == KEY_ENTER && key_event.control:
		on_test_finished()
		return
	if !key_event.pressed || key_event.echo:
		return

	validator.validate(event.physical_scancode)


func on_test_started() -> void:
	timer.start()


func on_test_finished() -> void:
	timer.stop()
	var time = timer.get_time()
	owner.typing_test.results.time = time
	owner.change_state("EndTestState")


func exit() -> void:
	.exit()
	yield(get_tree(), "idle_frame")
	timer.free()
	validator.queue_free()
	owner.ui_prompt.visible = false


func create_timer_from_mode(mode: int) -> void:
	if mode == TypingTest.RACE:
		timer = Stopwatch.new()
	if mode == TypingTest.TIME_ATTACK:
		timer = Timer.new()
	add_child(timer)