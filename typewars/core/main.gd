extends Node

onready var typing_test = TypingTest.new()

var key_display: Array

func _ready():
	add_child(typing_test)
	print(typing_test.test_text)
	typing_test.connect("test_started", self, "_on_test_started")


func _gui(delta) -> void:
	if !typing_test.has_started:
		return
	#GUI.label(typing_test.test_text[typing_test.text_index])
