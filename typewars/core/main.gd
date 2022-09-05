extends Node

onready var typing_test = $TypingTest
onready var prompt = $Control/CenterContainer/Label

var key_display: Array

func _ready():
	typing_test.connect("test_started", self, "_on_test_started")
	prompt.setup(typing_test.test_text)


func _gui(delta) -> void:
	if !typing_test.has_started:
		return
	#GUI.label(typing_test.test_text[typing_test.text_index])
