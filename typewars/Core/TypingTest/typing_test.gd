class_name TypingTest
extends Node

# TODO add standard tests as constants

# TIME_ATTACK: How many words in 60 seconds
# RACE: How fast can you write 100 words


enum {TIME_ATTACK, RACE}

var content: PoolStringArray setget set_content, get_content
var scancodes: PoolIntArray
var mode: int
var args: Dictionary
var results: Dictionary


# setters & getters
func set_content(value) -> void:
	content = value


func get_content() -> PoolStringArray:
	return content
