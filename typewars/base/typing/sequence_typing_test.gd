class_name SequenceTypingTest
extends TypingTest

var sequence_content: String
var allow_qwertz: bool = false


func set_content(value: String) -> void:
	if sequence_content == value:
		return

	sequence_content = value
	content = value.split(" ")


func get_qwertz(_force: bool = false) -> Array:
	if !allow_qwertz:
		return content as Array
	return [Qwertzyfier.qwertzyfy(content[0])]
