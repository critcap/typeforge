extends StateMachine

var test_list: Dictionary setget set_test_list, get_test_list
var validator: Validator setget set_validator

var typing_test: TypingTest
var stats_collector: TypingStatsCollector

onready var ui_prompt = $Prompt
onready var ui_list = $ListSelection
onready var ui_statistics = $StatisticsMenu
onready var ui_visualizer = $KeystrokeVisualizer
onready var ui_press_start = $PressStart


func _ready():
	change_state("InitState")


# region Setters & Getters


func set_test_list(list: Dictionary) -> void:
	test_list = list


func get_test_list() -> Dictionary:
	return test_list.duplicate()


func set_validator(_validator: Validator) -> void:
	if validator:
		remove_child(validator)
		validator.queue_free()
	validator = _validator
	add_child(validator)

# endregion
