class_name TestFactory
extends Node

const LENGTH = 999
const MIN_SIZE = 3
const MAX_SIZE = 8


static func assemble_test_from_data(raw: RawTestData) -> TypingTest:
	var test = TypingTest
	test.name = raw.name
	if !(raw.data is String):
		var data = (
			raw.data
			if is_qwerty_layout()
			else Qwertzyfier.qwertzify(raw.data.join(" ")).split(" ")
		)

		test.content = generate_random_test(data, LENGTH, MIN_SIZE, MAX_SIZE)
		return test

	test.content = raw.data
	return test


# random test generation
static func generate_random_test(data: Array, length: int, min_size: int, max_size: int) -> PoolStringArray:
	seed(OS.get_ticks_msec())
	var words = []
	for _i in range(length):
		words.append(_generate_word(data, min_size, max_size))
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


static func is_qwerty_layout() -> bool:
	return OS.get_latin_keyboard_variant() == "QWERTY"
