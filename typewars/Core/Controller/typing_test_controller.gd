extends StateMachine

export(String, FILE) var test_path: String


var typing_test: TypingTest
var validator: Validator
var test_list: Dictionary
var stats_collector: TypingStatsCollector


onready var ui_prompt = $Prompt
onready var ui_list = $ListSelection
onready var ui_statistics = $StatisticsMenu
onready var ui_visualizer = $KeystrokeVisualizer
onready var ui_press_start = $PressStart


func _ready():
	change_state("InitState")
