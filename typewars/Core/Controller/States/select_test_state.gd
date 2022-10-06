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


func on_item_selected(item: int, args: Dictionary) -> void:
	var test_data := owner.test_list.values()[item] as TypingTestData
	var test_list := owner.test_list as Dictionary
	var test := TypingTestFactory.assemble_test(test_data, args, test_list)
	test.scancodes = ScancodeConverter.convert_text_to_scancodes(test.content)
	owner.typing_test = test
	owner.add_child(test)

	change_state("SetupTestState")


func exit() -> void:
	.exit()
	menu.visible = false
