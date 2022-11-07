extends HBoxContainer


var selection_hints: = {"subentry":"", "ui_accept":""}

# region Methods
func create_hints_from_mapping(hints: Dictionary) -> Array:
	var labels = []
	var actions: = InputMap.get_actions()
	
	for key in hints.keys():
		if !InputMap.has_action(key):
			continue
		var binds = ProjectSettings.get_setting(str("input/",key))
		
		if binds.values().empty() || binds.events.empty():
			continue
		if !(binds.events[0] is InputEventKey):
			continue
		var scancode = binds.events[0].get_scancode_with_modifiers()
		var scancode_string: = OS.get_scancode_string(scancode)
		var hint_label = Label.new()
		hint_label.text = scancode_string
		labels.append(hint_label)
		
	return labels
	
	
func refresh(labels: Array) -> void:
	if !get_children().empty():
		for i in get_children():
			remove_child(i)
			i.free()
			
	for hint in labels:
		add_child(hint)
# endregion

# region Signal Listeners
func _on_TestController_state_changed(state_name):
	if state_name == "SelectTestState":
		refresh(create_hints_from_mapping(selection_hints))		
#endregion
