class_name TypingGenerator
extends Node

const HOMEROW = ["a", "s", "d", "f", "j", "k", "l", "ö"]

const MAX_WORDS: int = 8
const MIN_WORDS: int = 3


func generate_typing_string(length: int) -> Array:
	var words = []
	for _i in range(length):
		words.append(generate_word(MIN_WORDS, MAX_WORDS))
	return words


func generate_word(min_l, max_l) -> String:
	var word = ""
	while true:
		if is_word_finished(word, min_l, max_l):
			return word
		word += HOMEROW[randi() % HOMEROW.size()]

	return word


func is_word_finished(word: String, min_l, max_l) -> bool:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	if word.length() < min_l:
		return false
	if word.length() >= max_l:
		return true
	return true if round(randf()) == 1 else false
