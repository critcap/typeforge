extends ListMenu


func setup_statistics(result: TypingStatsResult) -> void:
	$Title.text = "Typing Statistics"

	create_entry(str("Total Words:  ", result.words))
	create_entry(str("Time:  ", result.time, "s"))
	create_entry(str("Words Per Minute:  ", result.wpm))
	create_entry(str("Accuracy:  ", result.accuracy * 100, "%"))
	add_child(Label.new())
	var fastest_key = ScancodeConverter.convert_code_to_string(result.fastest_key)
	var fastest_time = result.get_character_stats(result.fastest_key)[ETypingStats.FASTEST]
	create_entry(str("Fastest Key:  ", fastest_key.to_upper(), " in ", fastest_time, "s"))




