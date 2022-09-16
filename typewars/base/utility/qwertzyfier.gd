class_name Qwertzyfier


static func qwertzyfy(value: String) -> String:
	value = value.replacen("y", "§")
	value = value.replacen("z", "y")
	value = value.replacen("§", "z")
	value = value.replace(";", "ö")
	return value
