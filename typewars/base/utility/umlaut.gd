class_name Umlaut

# physical umlaut scancodes
const CODE_UE = 123     # ü
const CODE_OE = 59      # ö
const CODE_AE = 39      # ä
const CODE_SZ = 45      # ß


static func get_umlaut_from_scancode(scancode: int) -> String:
    if scancode == CODE_UE:
        return "ü"
    elif scancode == CODE_OE:
        return "ö"
    elif scancode == CODE_AE:
        return "ä"
    return ""


static func get_scancode_from_umlaut(character: String) -> int:
    if character == "ä":
        return CODE_AE
    elif character == "ö":
        return CODE_OE
    elif character == "ü":
        return CODE_UE
    return 0


static func is_umlaut(character: String) -> bool:
    return get_scancode_from_umlaut(character) != 0