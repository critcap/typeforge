class_name InitState
extends TestState

# TODO change to config or cache last used user
const TEST_USER_NAME = "test"
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

	# TODO Remove this
	if OS.is_debug_build():
		if ResourceLoader.exists(str("res://dev/", TEST_USER_NAME, ".tres")):
			var dir = Directory.new()
			dir.remove(str("res://dev/", TEST_USER_NAME, ".tres"))

	load_player_stats()
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


func load_player_stats() -> void:
	var resource_loader = ResourceLoader
	var player_stats: PlayerStats
	var path: String = str("res://dev/", TEST_USER_NAME, ".tres")

	if !resource_loader.exists(path):
		player_stats = PlayerStats.new()
		player_stats.username = TEST_USER_NAME
		var error_code = ResourceSaver.save(
			str("res://dev/", player_stats.username, ".tres"), player_stats
		)

		if error_code == 0:
			print(str("Save Success"))
		load_player_stats()
		return

	player_stats = ResourceLoader.load(path)
	print(player_stats.username)
