extends HBoxContainer

onready var indicator: Label = $Indicator
onready var item: Control = $Item


func _ready():
	item.connect("focus_entered", self, "select_item")
	item.connect("focus_exited", self, "deselect_item")


func setup(_name: String) -> void:
	item.text = _name


func select_item():
	if !item.has_focus():
		item.grab_focus()
	indicator.visible = true


func deselect_item():
	if item.has_focus():
		item.release_focus()
	indicator.visible = false