class_name SelectTestState
extends State

var list_display


func enter() -> void:
	.enter()
    # TODO setup display
    # TODO open display


func connect_signals() -> void:
	list_display.connect("item_selected", self, "on_item_selected")


func on_item_selected(item: int) -> void:
	var tests = owner.test_list
	if item >= tests.size():
		print("Selection is out of bounds")
	owner.selected_index = item

	owner.change_state("PrepareTestState")
