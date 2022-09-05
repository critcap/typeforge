extends Node
onready var generator: = TypingGenerator.new()

# generate text string

func _ready():
	print(OS.keyboard_get_layout_language(0))
	var testt_string = generator.generate_typing_string(40)
	var codes = ScancodeConverter.convert_text_to_scancodes(testt_string)
	var codies = []
	var word = ""
	for code in codes:
		if code == OS.find_scancode_from_string("Space"):
			codies.append(word)
			word = ""
			continue
		var is_umlaut = UmlautHandler.get_umlaut_from_scancode(code)
		string += OS.get_scancode_string(code) if is_umlaut == 0 else umlaut
	print(codies)



# get input

# convert into scancodes

# get input
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

	if event is InputEventKey:
		print(str(event.scancode, " ", OS.get_scancode_string(event.scancode)))

# evaluate input

# output evaluated input

# ouput input
