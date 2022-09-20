class_name SelectTestState
extends State

var menu: Control


func enter() -> void:
	.enter()
	setup_list_menu()


func setup_list_menu() -> void:
	menu = owner.ui_list

	var list := owner.test_list as Dictionary

	if list.size() == 0:
		menu.setup_list(["No tests found"])
		return

	menu.setup_list(list.keys())

	menu.connect("item_selected", self, "on_item_selected")
	#menu.connect("item_selected", owner, "set_selected_test")
	menu.open()


func on_item_selected(item: int) -> void:
	owner.selected_test = item
	owner.change_state("SetupTestState")
