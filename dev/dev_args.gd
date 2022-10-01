extends Node


func _ready():
	$ArgumentsSubentry.setup({
		"combine":["pimmel", "Hoden", 123],
		"mode": 2,
	})