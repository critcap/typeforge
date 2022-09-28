class_name SpecialUtility

# physical umlaut scancodes
const CODE_UE = 123  # ü
const CODE_UE_WIN = 59
const CODE_OE = 59  # ö
const CODE_OE_WIN = 96
const CODE_AE = 39  # ä
const CODE_SZ = 45  # ß


static func get_umlaut_from_scancode(scancode: int) -> String:
	if scancode == CODE_UE:
		return "ü"
	elif scancode == CODE_OE:
		return "ö"
	elif scancode == CODE_AE:
		return "ä"
	return ""


static func get_scancode_from_special_string(character: String) -> int:
	if character == "ä":
		return CODE_AE
	elif character == "ö":
		return CODE_OE if OS.get_name() != "Windows" else CODE_OE_WIN
	elif character == "ü":
		return CODE_UE if OS.get_name() != "Windows" else CODE_UE_WIN
	elif character == ",":
		return KEY_COMMA
	elif character == ".":
		return KEY_PERIOD
	return 0


static func is_umlaut(character: String) -> bool:
	return get_scancode_from_special_string(character) != 0
