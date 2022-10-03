class_name SelectTestState
extends TestState

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
	
	menu.setup_list(list.values())
	menu.connect("item_selected", self, "on_item_selected")
	menu.open()





func on_item_selected(item: int, subentry: Dictionary) -> void:
	owner.selected_test = item
	change_state("SetupTestState")


func exit() -> void:
	.exit()
	menu.visible = false
