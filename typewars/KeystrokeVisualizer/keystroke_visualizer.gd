class_name KeystrokeVisualizer
extends Control

export (float, 0.0, 1.0) var max_content_width: float = 0.6

var active: Label setget , get_active

onready var body: = $Body


func get_active() -> Label:
	return body.get_children()[-1] if body.get_children().size() > 0 else null


func _unhandled_input(event):
	if !(event is InputEventKey):
		return

	var key_event := event as InputEventKey

	if !key_event.pressed || key_event.echo:
		return

	if key_event.scancode == KEY_SPACE:
		add_new_block()
		var letter = Visualizer.visualize_input(key_event.scancode)
		write(letter)
		add_new_block()
		return
	
	var stylized = Visualizer.visualize_input(key_event.scancode)
	write(stylized)


func write(letter: String) -> void:
	if self.active == null:
		add_new_block()

	active.text += letter

	if get_content_size().x > body.rect_size.x * max_content_width:
		body.get_child(0).free()


func add_new_block() -> void:
	active = Label.new()
	body.add_child(active)


func get_content_size() -> Vector2:
	var size = Vector2.ZERO
	for child in body.get_children():
		size.y = max(size.y, child.rect_size.y)
		size.x += child.rect_size.x
	return size
