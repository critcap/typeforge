class_name EndTestState
extends TestState

var analyzer
var menu


func _ready():
	analyzer = TypingStatsAnalyzer.new()
	add_child(analyzer)


func enter() -> void:
	.enter()
	menu = owner.ui_statistics
	menu.visible = true

	var collector := owner.stats_collector as TypingStatsCollector
	analyzer.analyze_typing_stats(collector.data, collector.time, collector.words)


func connect_signals() -> void:
	analyzer.connect("stats_analyzed", self, "on_stats_analyzed")


func exit() -> void:
	.exit()
	menu.visible = false
	if owner.ui_press_start:
		owner.ui_press_start.visible = false
	can_reload = false
	can_quit = false


func on_stats_analyzed(results: TypingStatsResult) -> void:
	menu.setup(results)
	if owner.ui_press_start:
		owner.ui_press_start.visible = true
	can_reload = true
	can_quit = true


func unhandled_input(event: InputEvent) -> void:
	.unhandled_input(event)
	if event.is_action_pressed("ui_accept"):
		self.on_quit_test()
