class_name PlayerStatsManager
extends Node

const TEST_USER_NAME = "test"


func _ready():
	if OS.is_debug_build():
		if ResourceLoader.exists(str("res://dev/", TEST_USER_NAME, ".tres")):
			var dir = Directory.new()
			dir.remove(str("res://dev/", TEST_USER_NAME, ".tres"))


func get_files(path):
	var files = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin(true)

	var file = dir.get_next()
	while file != "":
		if dir.current_is_dir():
			continue
		files += [file]
		file = dir.get_next()

	return files


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