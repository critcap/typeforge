class_name PlayerStatsManager
extends Node

# region PROPERTIES
const DEFAULT_USERNAME = "local"
const DEFAULT_DIRECTORY = "user://"

var user_name
var results
var settings

var _data: PlayerStats

# endregion

# region Public Methods


func get_current_user_path() -> String:
	if OS.is_debug_build():
		return str("res://dev/", DEFAULT_USERNAME)
	return str(DEFAULT_DIRECTORY, DEFAULT_USERNAME)


# endregion

# region Private Methods


func _ready():
	# clear player data in debug before player data look up
	if OS.is_debug_build():
		_delete_player_data()

	var data = _load_player_data(DEFAULT_USERNAME)
	if !data:
		data = _create_new_player_data(DEFAULT_USERNAME)
	print(data.username)

func _load_player_data(_name: String):
	var resource_loader = ResourceLoader
	var player_stats: PlayerStats
	var path: String = str(get_current_user_path(), ".tres")

	if !resource_loader.exists(path):
		return

	player_stats = ResourceLoader.load(path)
	if player_stats is PlayerStats:
		return player_stats


func _create_new_player_data(_user_name) -> PlayerStats:
	var player_stats = PlayerStats.new()
	player_stats.username = _user_name
	player_stats.results = []

	_save_player_data(player_stats)

	return player_stats


func _save_player_data(_player_data: PlayerStats = _data) -> void:
	if !_player_data:
		print("Error: No PlayerStats to save")
		return
	var error_code = ResourceSaver.save(str(get_current_user_path(), ".tres"), _player_data)
	if error_code == 0:
		print(str("Save Success"))


func _delete_player_data(_player_data: PlayerStats = _data) -> void:
	var path = str(get_current_user_path(), ".tres")
	if ResourceLoader.exists(path):
		var dir = Directory.new()
		dir.remove(path)

	# region user data lookup
	# Not needed at this moment
	# func do_player_data_lookup(path):
	# 	var files = []
	# 	var dir = Directory.new()

	# 	dir.open(path)
	# 	dir.list_dir_begin(true)

	# 	var file := dir.get_next() as String
	# 	while file != "":
	# 		# skip sub directories
	# 		if dir.current_is_dir():
	# 			continue

	# 		# check if its a resource
	# 		var file_type = file.split(".")[-1]
	# 		if !file_type || (file_type != "tres" && file_type != "res"):
	# 			file = dir.get_next()
	# 			continue

	# 		files += [file]
	# 		file = dir.get_next()

	# 	return files
	# endregion
# endregion
