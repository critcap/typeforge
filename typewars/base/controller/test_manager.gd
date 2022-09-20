extends StateMachine


var selected_test: TypingTestData setget set_selected_test, get_selected_test

var test_path: String
var typing_test: TypingTest
var data_loader: Dataloader
var validator: Validator
var test_list: Dictionary
var _selected_index: int

onready var prompt_display = $Control/CenterContainer/Label


func set_selected_test(value) -> void:
    _selected_index = value


func get_selected_test() -> TypingTestData:
    var index = _selected_index if _selected_index else 0
    return test_list[index] as TypingTestData


func _ready():
    pass