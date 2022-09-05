class_name Visualizer
extends Node


static func visualize_input(scancode: int) -> String:
	var key = OS.get_scancode_string(scancode)
	return key if key.length() == 1 else _parse_modifier_key_as_symbol(key)


# More Symbols
# https://www.lifewire.com/what-are-windows-keyboard-equivalents-to-mac-2260203#:~:text=In%20this%20example%2C%20you%20want,to%20perform%20the%20Option%20action.

static func _parse_modifier_key_as_symbol(key_string: String) -> String:
	key_string = key_string.to_lower()
	match key_string:
		"control":
			return "^"
		"shift":
			return "⇧"
		"command":
			return "⌘"
		"alt", "options", "meta":
			return "⌥"
		"space":
			return "␣"
		_:
			return ""
