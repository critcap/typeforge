extends HBoxContainer

var debug_hints: = {"debug": "debug"}
var selection_hints: = {"subentry":"", "ui_accept":""}
var test_hints: = {"reload_test":"", "quit_test":""}
var end_hints: = {"reload_test":"", "quit_test":"", "ui_accept": ""}

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
			
		# get scancode text from bound events
		# TODO expand filtering for actions with more binds
		if !(binds.events[0] is InputEventKey):
			continue
		var scancode = binds.events[0].get_scancode_with_modifiers()
		var scancode_string: = OS.get_scancode_string(scancode)
		
		# build label and label text
		var hint_label = Label.new()
		hint_label.text = str(scancode_string,":",hints[key]).to_lower()
		labels.append(hint_label)
	
	# adds debug options if in debug mode
	if OS.is_debug_build() && !hints.has("debug"):
		labels += create_hints_from_mapping(debug_hints)
	return labels
	
	
func refresh(labels: Array) -> void:
	if !get_children().empty():
		for i in get_children():
			remove_child(i)
			i.free()
			
	for hint in labels:
		add_child(hint)
	visible = true
# endregion

# region Signal Listeners
func _on_TestController_state_changed(state_name):
	if state_name == "SelectTestState":
		refresh(create_hints_from_mapping(selection_hints))
		return
	elif state_name == "TypeRaceTestState" || state_name == "TimeAttackTestState":
		refresh(create_hints_from_mapping(test_hints))
		return
	elif state_name == "EndTestState":
		refresh(create_hints_from_mapping(end_hints))
		return
	else:
		visible = false
#endregion
