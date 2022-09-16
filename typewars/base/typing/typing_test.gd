class_name TypingTest
extends Node

# TODO add standard tests as constants

var test_name: String
var content: PoolStringArray setget set_content, get_content
var qwertz: Array setget , get_qwertz
var force_qwertz: bool = false


# setters & getters
func set_content(value) -> void:
	content = value


func get_content() -> PoolStringArray:
	return content


# private methods


# public methods
func has_qwertz() -> bool:
	return qwertz != null && !qwertz.empty()


func get_qwertz(force: bool = force_qwertz) -> Array:
	if !has_qwertz() && !force:
		return []

	if force && !has_qwertz():
		return Qwertzyfier.qwertzyfy(content.join(" ")).split(" ") as Array

	return qwertz
