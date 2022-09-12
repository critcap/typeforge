extends Node

onready var typing_test = $TypingTest
onready var prompt = $Control/CenterContainer/Label

var file_path = "res://dev/test.yaml"

#var key_display: Array


func _ready():
	yield(load_exercises(), "completed")
	typing_test.connect("test_started", self, "_on_test_started")
	prompt.setup(typing_test.test_text)


func load_exercises():
	var loader = ExerciseDataLoader.new()
	loader.connect("exercises_loaded", self, "_on_exercises_loaded")
	loader.load_exercises(file_path)

func _on_exercises_loaded(exercises: Array):
	print(exercises)

# func _gui(delta) -> void:
# 	if !typing_test.has_started:
# 		return
# 	#GUI.label(typing_test.test_text[typing_test.text_index])
