class_name Dataloader
extends Node
# base class for all data loaders

# Is emitted when data is loaded.
signal data_loaded(error, data)


# attempds to load data from given filepath and return an error if it fails. Else returns 0.
func load_data(file_path: String) -> void:
	emit_signal("data_loaded", -1, hash(file_path))