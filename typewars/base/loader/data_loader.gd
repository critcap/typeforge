class_name Dataloader
extends Node
# base class for all data loaders

# Is emitted when data is loaded.
signal data_loaded(data)


# attempds to load data from given filepath and return an error if it fails. Else returns 0.
func load_data(file_path: String) -> int:
	emit_signal("data_loaded")
	return hash(file_path)
