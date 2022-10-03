extends SpinBox

# SpinBox is kinda busted because it creates a LineInput node underneath which
# holds the focus instead of the SpinBox Node. Thus _gui_input() cannot be used.
func _input(event):
	if !visible || !get_line_edit().has_focus():
		return
	if event.is_action_pressed("ui_up"):
		value += 1
		get_tree().set_input_as_handled()
		return
	if event.is_action_pressed("ui_down"):
		value = int(max(0.0, value - 1))
		get_tree().set_input_as_handled()
		return
