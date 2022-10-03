class_name ListMenu
extends VBoxContainer

signal item_selected(index, subentry)

export (PackedScene) var Entry: PackedScene


func setup_list(input) -> void:
	pass


func create_focus_wrapping() -> void:
	if get_children().empty():
		return
	var first := get_children()[0].item as Button
	var last := get_children()[-1].item as Button

	first.set_focus_neighbour(MARGIN_TOP, last.get_path())
	last.set_focus_neighbour(MARGIN_BOTTOM, first.get_path())


func on_item_pressed(subentry: Dictionary, item_index: int) -> void:
	if !visible:
		return
	emit_signal("item_selected", item_index, subentry)


func open() -> void:
	visible = true
	if get_children().empty():
		return
	get_children()[0].select_item()
	
	
func close() -> void:
	visible = false


func clear() -> void:
	if get_children().size() == 0:
		return

	for child in get_children():
		remove_child(child)
		child.free()
