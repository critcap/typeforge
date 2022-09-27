class_name ListMenu
extends VBoxContainer

signal item_selected(index)

var index: int

onready var ListItem = load("res://typewars/Core/UI/ListMenu/ListEntry.tscn")


func _ready():
	visible = false


func open() -> void:
	visible = true
	if get_children().empty():
		return
	get_children()[0].select_item()


# is quite lazy always creates a comple new list
# but godot is fast with instancing objects and doenst benefit
# that much from pooling.
func setup_list(items: Array) -> void:
	clear()
	for item in items:
		var list_item = ListItem.instance()
		add_child(list_item)

		var item_name = get_item_name_text(item)
		item_name = str("item ", items.find(item)) if item_name == "" else item_name
		list_item.setup(item_name)

		list_item.item.connect("pressed", self, "on_item_pressed", [items.find(item)])

	# setting the first and last elements to wrap
	var first := get_children()[0].item as Button
	var last := get_children()[-1].item as Button

	first.set_focus_neighbour(MARGIN_TOP, last.get_path())
	last.set_focus_neighbour(MARGIN_BOTTOM, first.get_path())


func on_item_pressed(item_index: int) -> void:
	if !visible:
		return
	emit_signal("item_selected", item_index)


func get_item_name_text(item) -> String:
	if item is String:
		return item
	if "name" in item:
		return item.name
	return ""


func clear() -> void:
	if get_children().size() == 0:
		return

	visible = false
	for child in get_children():
		child.queue_free()
