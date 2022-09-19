extends StateMachine

var test_path: String
var typing_test: TypingTest
var data_loader: Dataloader
var validator: Validator
var test_list: Dictionary
var selected_index: int

onready var prompt_display = $Control/CenterContainer/Label


func _ready():
	
