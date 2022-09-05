class_name InputOverlay
extends Node

export (float, 0.0, 10.0) var decay_time: float = 1.0

var _register: Array
var _active: String


func _gui(_delta) -> void:
	GUI.label(_active)


func _input(event):
	if !(event is InputEventKey):
		return
	var key_event: = event as InputEventKey
	if !key_event.pressed || key_event.echo:
		return
	var key_string = OS.get_scancode_string(key_event.scancode)
	_active += key_string if key_string.length() == 1 else _parse_modifier_key(key_string)



func _parse_modifier_key(key_string: String) -> String:
	var shift = hash("Shift")
	var control = hash("Control")
	var command = hash("Command")
	var key_hash = hash(key_string)
	match key_hash:
		shift:
			return "^"

		control:
			return "Ctrl"

		command:
			return "Cmd"
		_:
			return "+"
