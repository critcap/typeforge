class_name ListEntry
extends HBoxContainer

signal pressed

# TODO add assginent in list_menu
onready var subentry: = $ArgumentsSubentry as SubentryBase
onready var indicator: Label = $IndicatorSelect
onready var item: Control = $Item


func setup(_name: String) -> void:
	item.text = _name


func select_item():
	item.visible = true
	indicator.visible = true
	if !item.has_focus():
		item.grab_focus()


func deselect_item():
	if item.has_focus():
		item.release_focus()
	indicator.visible = false


func _on_item_pressed():
	if !Input.is_key_pressed(KEY_SHIFT) || subentry == null || subentry.get_children().empty():
		emit_signal("pressed")
		return
	subentry.visible = true
	subentry.select_item()


func has_subentry() -> bool:
	return subentry != null
