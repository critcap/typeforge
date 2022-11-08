extends Node


func _ready():
	var controller = $TestController
	controller.ui_select = get_node("%TestSelectionMenu")
	controller.ui_statistics = get_node("%StatisticsMenu")
	controller.ui_prompt = get_node("%InputPrompt")

	controller.start()
