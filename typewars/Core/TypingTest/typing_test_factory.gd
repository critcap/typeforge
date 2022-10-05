class_name TypingTestFactory
extends Node

const SIZE = 20
const MIN_SIZE = 3
const MAX_SIZE = 8


static func assemble_test_from_data(raw: TypingTestData, combine: Array = []) -> TypingTest:
	var test = TypingTest.new()
	var size: int = raw.arguments["size"] if raw.arguments["size"] != 0 else SIZE
	test.name = raw.name if raw.name != "" else "Test"
	test.mode = raw.arguments["mode"] if raw.arguments["mode"] != 0 else TypingTestModes.RACE

	if raw.data is Array && !raw.data.empty():
		var data = generate_random_test_content(raw.data, combine)
		test.content = generate_random_test(data, size, MIN_SIZE, MAX_SIZE)
		return test
	elif raw.data is String and (raw.data != ""):
		test.content = generate_content_from_string(raw.data, size)
		return test

	push_error("No data found for test: " + test.name)
	return test


# region String Content Generation
static func generate_content_from_string(data: String, repeats: int = 0) -> PoolStringArray:
	var content := data.split(" ")
	if repeats > 0:
		for _i in range(repeats):
			content += data.split(" ")
	return content


# endregion


# region Random Test Generation
static func generate_random_test_content(data: PoolStringArray, combine: Array) -> PoolStringArray:
	data = data as PoolStringArray
	data += combine as PoolStringArray
	var new_data = data if is_qwerty_layout() else Qwertzyfier.qwertzify(data.join(" ")).split(" ")
	return new_data


static func generate_random_test(data: Array, l: int, _min: int, _max: int) -> PoolStringArray:
	seed(OS.get_ticks_msec() + OS.get_unix_time())
	var words = []
	for _i in range(l):
		words.append(_generate_word(data, _min, _max))
	return words


static func _generate_word(data: Array, min_l, max_l) -> String:
	var word = ""
	while true:
		if is_word_finished(word, min_l, max_l):
			return word
		randomize()
		word += data[randi() % data.size()]

	return word


static func is_word_finished(word: String, min_l, max_l) -> bool:
	randomize()
	if word.length() < min_l:
		return false
	if word.length() >= max_l:
		return true
	return true if round(randf()) == 1 else false


# endregion


# region Utils
static func is_qwerty_layout() -> bool:
	return OS.get_latin_keyboard_variant() == "QWERTY" if OS.get_name() != "HTML5" else false

# endregion
