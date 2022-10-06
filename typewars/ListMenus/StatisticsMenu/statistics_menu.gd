extends ListMenu


func setup_statistics(result: TypingStatsResult) -> void:
	if !get_children().empty():
		clear()

	var title = Label.new()
	title.text = "Typing Statistics"
	add_child(title)
	create_entry(str("Total Words:  ", result.words))
	create_entry(str("Time:  ", result.time, "ms"))
	create_entry(str("Words Per Minute:  ", result.wpm))
	create_entry(str("Accuracy:  ", result.accuracy * 100, "%"))
	create_entry(str("Errors:  ", result.total_errors))
	add_child(Label.new())
	var fastest_key = ScancodeConverter.convert_code_to_string(result.fastest_key)
	var fastest_time = result.get_character_stats(result.fastest_key)[ETypingStats.FASTEST]
	create_entry(str("Fastest Key:  ", fastest_key.to_upper(), " in ", fastest_time, "s"))


func refresh_statistics(result: TypingStatsResult) -> void:
	if get_children().size() < 1:
		return
	get_child(0).text = str("Total Words:  ", result.words)
	get_child(1).item.text = str("Time:  ", result.time, "ms")
	get_child(2).item.text = str("Words Per Minute:  ", result.wpm)
	get_child(3).item.text = str("Accuracy:  ", result.accuracy * 100, "%")
	get_child(4).item.text = str("Errors:  ", result.total_errors)
	var fastest_key = ScancodeConverter.convert_code_to_string(result.fastest_key)
	var fastest_time = result.get_character_stats(result.fastest_key)[ETypingStats.FASTEST]
	get_child(5).item.text = str("Fastest Key:  ", fastest_key.to_upper(), " in ", fastest_time, "s")
