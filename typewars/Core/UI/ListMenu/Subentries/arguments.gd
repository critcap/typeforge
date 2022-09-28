extends HBoxContainer


func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		if owner == null:
			return
		owner.select_item()