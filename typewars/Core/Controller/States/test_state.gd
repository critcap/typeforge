class_name TestState
extends State

var can_reload: bool = false
var can_quit: bool = false

# wrapper method for changing states
func change_state(state: String) -> void:
	if owner == null || !owner.has_method("change_state"):
		print("Error owner cannot change state")

	yield(get_tree(), "idle_frame")
	owner.change_state(state)


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
	change_state("SetupTestState")


func on_quit_test() -> void:
	if owner == null:
		return
	change_state("SelectTestState")
