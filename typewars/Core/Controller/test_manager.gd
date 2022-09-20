extends StateMachine

var selected_test: TypingTestData setget set_selected_test, get_selected_test

export(String, FILE) var test_path: String

var typing_test: TypingTest
var data_loader: Dataloader
var validator: Validator
var test_list: Dictionary
var _selected_index: int

onready var ui_prompt = $Label
onready var ui_list = $ListSelection


func set_selected_test(value) -> void:
	_selected_index = value


func get_selected_test() -> TypingTestData:
	var index = _selected_index if _selected_index else 0
	var key = test_list.keys()[index]
	return test_list[key] as TypingTestData


func _ready():
	change_state("InitState")
	pass
