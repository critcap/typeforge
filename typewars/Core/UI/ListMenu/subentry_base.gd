class_name SubentryBase
extends AspectRatioContainer

# first node to grab focus on show
export(NodePath) var first_born: NodePath
# Is not typed because different types of subentries have different types of data
var data

onready var is_static: bool = first_born != null


# region Methods
func setup(_args) -> void:
	pass


func select_item():
	var item = get_node(first_born)
	if item == null:
		get_focus_owner().release_focus()
		return
	item.grab_focus()


func deselect_item():
	if !visible || owner == null:
		return
	owner.select_item()
	get_tree().set_input_as_handled()


# endregion


# region Private Methods
func _input(event):
	if !is_static:
		return
	if event.is_action_pressed("ui_cancel"):
		deselect_item()
	return


func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		deselect_item()
# endregion
