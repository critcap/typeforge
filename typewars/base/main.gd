extends Node

var file_path = "res://dev/test.yaml"
var data_loader: Dataloader = YamlDataLoader.new()
var tests: Array

onready var typing_test = $TypingTest
onready var prompt = $Control/CenterContainer/Label

#var key_display: Array


func _ready():
	add_child(data_loader)
	load_startup(file_path)
	print("world")


func startup(path: String) -> void:
	load_tests(path)
	yield(data_loader, "data_loaded")

	#TODO add selection
	var 

func load_tests(path: String):
	data_loader.connect("data_loaded", self, "_on_data_loaded")
	data_loader.load_data(path)


func _on_data_loaded(error: int, tests: Array):
	if error != 0:
		print("Error loading data with error code: ", error)
		return
	for test in tests:
		print(test.names)
		if tests == null:
			tests = []
		tests.append(test)
