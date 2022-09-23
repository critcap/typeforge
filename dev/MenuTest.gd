extends Node

export (int, 0, 20) var count: int

func _ready():
	var list = $ListSelection
	var nodes = []
	for i in count:
		var node = Node.new()
		node.name = "item " + str(i)
		add_child(node)
		nodes.append(node)

	list.setup_list(nodes)
	list.open()
