class_name TestState
extends State

var can_reload: bool = false
var can_quit: bool = false


func unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("reload_test") && can_reload:
		on_reload_test()
		return
	if event.is_action_pressed("quit_test") && can_quit:
		on_quit_test()
		return


func on_reload_test() -> void:
	if owner == null:
		return
	owner.change_state("SetupTestState")


func on_quit_test() -> void:
	if owner == null:
		return
	owner.change_state("SelectTestState")
