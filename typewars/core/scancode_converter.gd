class_name ScancodeConverter
extends Node


static func convert_text_to_scancodes(text: Array) -> Array:
	var scancodes = []
	var space = OS.find_scancode_from_string("Space")
	for word in text:
		for character in word:
			var scancode: int

			if OS.keyboard_get_layout_language(0) == "de":
				scancode = _handle_german_layout(character)
				scancodes.append(scancode)
				continue

			scancodes.append(OS.find_scancode_from_string(character))

		# at the end of each word add a space if its not at the last word
		if word == text[-1]:
			break
		scancodes.append(space)

	return scancodes


static func _handle_german_layout(character: String) -> int:
	var scancode = OS.find_scancode_from_string(character)
	return scancode if scancode != 0 else UmlautHandler.get_scancode_from_umlaut(character)