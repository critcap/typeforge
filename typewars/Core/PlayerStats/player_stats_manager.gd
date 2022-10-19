class_name PlayerStatsManager
extends Node




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
