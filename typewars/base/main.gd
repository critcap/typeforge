extends Node

var file_path = "res://dev/test.yaml"
var data_loader: Dataloader = YamlDataLoader.new()

onready var typing_test = $TypingTest
onready var prompt = $Control/CenterContainer/Label

#var key_display: Array


func _ready():
	load_exercises()
	typing_test.connect("test_started", self, "_on_test_started")
	prompt.setup(typing_test.test_text)


func load_exercises():
	data_loader.connect("data_loaded", self, "_on_data_loaded")
	var error = data_loader.load_data(file_path)
	if error != 0:
		print(error)
		return


func _on_data_loaded(exercises: Array):
	print(exercises)
