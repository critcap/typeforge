class_name TypingTest
extends Node

# TODO add standard tests as constants

var content: PoolStringArray setget set_content, get_content
var scancodes: PoolIntArray

# setters & getters
func set_content(value) -> void:
	content = value


func get_content() -> PoolStringArray:
	return content