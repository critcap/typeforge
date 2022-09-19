class_name TypingTest
extends Node

# TODO add standard tests as constants

var content: PoolStringArray setget set_content, get_content
var qwertz: PoolStringArray setget , get_qwertz
var force_qwertz: bool = false


# setters & getters
func set_content(value) -> void:
	content = value


func get_content() -> PoolStringArray:
	return content


# public methods
func has_qwertz() -> bool:
	return qwertz != null && !qwertz.empty()


func get_qwertz(force: bool = force_qwertz) -> PoolStringArray:
	if !has_qwertz() && !force:
		return [] as PoolStringArray

	if force && !has_qwertz():
		return Qwertzyfier.qwertzyfy(content.join(" ")).split(" ")
	return qwertz
