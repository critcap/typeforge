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
	var collector = owner.stats_collector
	analyzer.analyze_typing_stats(collector.data, collector.time, collector.words)


func connect_signals() -> void:
	analyzer.connect("stats_analyzed", self, "on_stats_analyzed")


func exit() -> void:
	.exit()
	menu.visible = false


func on_stats_analyzed(results: TypingStatsResult) -> void:
	results = results
	print(results.wpm)


func unhandled_input(event: InputEvent) -> void:
	.unhandled_input(event)
	if event.is_action_pressed("ui_accept"):
		change_state("SelectTestState")