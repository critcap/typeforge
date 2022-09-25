class_name TypingStatsResult
extends Reference

var wpm: float
var cpm: float
var accuracy: float
var total_strokes: int

var time: int
var words: int
var total_errors: int
var total_correct: int
var most_pressed_key: int
var least_pressed_key: int
var most_accurate_character: int
var least_accurate_character: int
var fastest_character: int
var slowest_character: int

var _data: Dictionary


func get_character_stats(character: int):
    return  _data[character]
