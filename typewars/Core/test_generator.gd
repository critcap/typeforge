class_name TextGenerator
extends Node

const HOMEROW = ["a", "s", "d", "f", "j", "k", "l", "ö"]

const MAX_WORDS: int = 8
const MIN_WORDS: int = 3


static func generate_typing_string(length: int) -> Array:
	seed(OS.get_ticks_msec())
	var words = []
	for _i in range(length):
		words.append(_generate_word(MIN_WORDS, MAX_WORDS))
	return words


static func _generate_word(min_l, max_l) -> String:
	var word = ""
	while true:
		if is_word_finished(word, min_l, max_l):
			return word
		randomize()
		word += HOMEROW[randi() % HOMEROW.size()]

	return word


static func is_word_finished(word: String, min_l, max_l) -> bool:
	randomize()
	if word.length() < min_l:
		return false
	if word.length() >= max_l:
		return true
	return true if round(randf()) == 1 else false
