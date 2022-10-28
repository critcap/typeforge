class_name PlayerStatsManager
extends Node

# region PROPERTIES

const DEBUG_USER_NAME: String = "DEBUG"
const DEBUG_DIRECTORY: String = "res://dev/"
const CLEAR_DEBUG: bool = true

var _current_user: String

# endregion

# region Methods


func _ready():
	if OS.is_debug_build() && CLEAR_DEBUG:
		var path = str(get_current_user_path(), ".tres")
		if ResourceLoader.exists(path):
			var dir = Directory.new()
			dir.remove(path)


func get_current_user_path() -> String:
	if OS.is_debug_build():
		return str(DEBUG_DIRECTORY, DEBUG_USER_NAME)

	# TODO
	return ""


func do_user_lookup(path):
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
	var path: String = str(get_current_user_path(), ".tres")

	if !resource_loader.exists(path):
		player_stats = PlayerStats.new()
		player_stats.username = DEBUG_USER_NAME
		var error_code = ResourceSaver.save(
			str(DEBUG_DIRECTORY, player_stats.username, ".tres"), player_stats
		)

		if error_code == 0:
			print(str("Save Success"))
		load_player_stats()
		return

	player_stats = ResourceLoader.load(path)
	print(player_stats.username)

# endregion
