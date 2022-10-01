class_name SubentryTestArguments
extends SubentryBase
# Subentry to represend Typing Test arguments

# TODO add to base args 
const BASE_SIZE = 60
const BASE_MODE = 1

var _base_data: Dictionary
# Argument Controls
var _combine: Array
var _mode: Button
var _size_label: Label
var _size_input: SpinBox

onready var _body := $Body


func get_data() -> Dictionary:
	var data := {}
	data["combine"] = _get_combine_values()
	data["mode"] = int(_mode.pressed)
	data["size"] = int(_size_input.text)
	return data


func setup(args: Dictionary) -> void:
	if args.has("combine") && args["combine"] is Array:
		for i in args["combine"]:
			var button = Button.new()
			button.text = str(i)
			button.toggle_mode = true
			_body.add_child(button)
			_combine.append(button)
		first_born = _combine[0].get_path()
	
	# create mode button
	var mode = args["mode"] if args.has("mode") else BASE_MODE
	_mode = Button.new()
	_mode.text = TypingTestModes.mode_to_string(mode)
	_mode.toggle_mode = true
	_mode.pressed = int(mode)
	_mode.connect("toggled", self, "_on_mode_toggled") 
	_body.add_child(_mode)
	if !first_born:
		first_born = _mode.get_path()
	
	# create size input
	var size_body = HBoxContainer.new()
	_body.add_child(size_body)
	_size_label = Label.new()
	_size_label.text = "Length:" if mode == 1 else "Time:"
	size_body.add_child(_size_label)
	var size = args["size"] if args.has("size") else BASE_SIZE
	_size_input = SpinBox.new()
	_size_input.value = size
	size_body.add_child(_size_input)
	

func _on_mode_toggled(status: bool) -> void:
	_mode.text = TypingTestModes.mode_to_string(int(status))
	_size_label.text = "Length:" if status else "Time:"


func _get_combine_values() -> Array:
	var values = []
	if !_combine || _combine.empty():
		return values
	for i in _combine:
		if i.pressed:
			values.append(i.text)
	return values