class_name InitState
extends TestState

const TESTS = {
	"homerow":
	{
		"content": ["a", "s", "d", "f", "j", "k", "l", ";", "g", "h"],
		"args": {"combine": ["toprow", "bottomrow"], "mode": 1, "size": 50}
	},
	"toprow":
	{
		"content": ["q", "w", "e", "r", "t", "y", "u", "i", "o"],
		"args": {"combine": ["homerow", "bottomrow"], "mode": 1, "size": 50}
	},
	"bottomrow":
	{
		"content": ["z", "x", "c", "v", "b", "n", "m", ",", "."],
		"args": {"combine": ["toprow", "homerow"], "mode": 1, "size": 50}
	},
	"brown_fox":
	{"content": "The quick brown fox jumps over the lazy dog", "args": {"mode": 1, "size": 5}},
	"common_german": {"content": CommonWords.GERMAN, "args": {"mode": 1, "size": 60}},
	"common_english": {"content": CommonWords.ENGLISH, "args": {"mode": 1, "size": 60}},
}


func enter() -> void:
	.enter()
	initialize()
	change_state("SelectTestState")


func initialize() -> void:
	# ? possibly add back properties (Single responsibility)
	owner.stats_collector = TypingStatsCollector.new()
	owner.add_child(owner.stats_collector)
	owner.validator = Validator.new()

	var tests = {}
	for key in TESTS.keys():
		var test = TypingTestData.new()
		test.name = key
		test.data = TESTS[key]["content"] if TESTS[key].has("content") else ""
		test.arguments = TESTS[key]["args"] if TESTS[key].has("args") else {}
		tests[key] = test
	owner.test_list = tests
