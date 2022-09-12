class_name TypingExercise
extends Node

# TODO add standard tests as constants

var test_name: String
var content: PoolStringArray
var qwertz: Array setget , get_qwertz
var force_qwertz: bool = false


func _init(_name: String, _content: Array) -> void:
	name = _name
	content = _content


func has_qwertz() -> bool:
	return qwertz != null && !qwertz.empty()


func get_qwertz(force: bool = force_qwertz) -> Array:
	if !has_qwertz() && !force:
		return []

	if force && !has_qwertz():
		return Qwertzyfier.qwertzyfy(content.join(" ")).split(" ") as Array

	return qwertz
