extends StateMachine

export(String, FILE) var test_path: String

var selected_test: TypingTestData setget set_selected_test, get_selected_test
var typing_test: TypingTest
var data_loader: Dataloader
var validator: Validator
var test_list: Dictionary
var _selected_index: int

onready var ui_prompt = $Prompt
onready var ui_list = $ListSelection
onready var ui_statistics = $Statistics


func set_selected_test(value) -> void:
	if value == null || !(value is int) || value >= test_list.size():
		print("test index out of range")
		return
	_selected_index = value


func get_selected_test() -> TypingTestData:
	var index = _selected_index if _selected_index else 0
	var key = test_list.keys()[index]
	return test_list[key] as TypingTestData


func _ready():
	change_state("InitState")
	pass
