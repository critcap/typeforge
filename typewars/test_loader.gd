class_name ExerciseDataLoader
extends Node

signal exercises_loaded(exericeses)

var yaml = preload("res://addons/godot-yaml/gdyaml.gdns").new()


func load_exercises(file_path: String) -> int:
	var file = File.new()
	var error = file.open(file_path, File.READ)
	if error != 0:
		print("Error opening file: " + file_path)
		return error


	var content = file.get_as_text()
	var yaml_content = yaml.parse(content).result[0]
	var exercises = get_tests(yaml_content)
	emit_signal("exercises_loaded", exercises)
	return 0


func get_tests(yaml_content):
	if !yaml_content.has("tests") || yaml_content["tests"].empty():
		return null

	var yaml_tests = yaml_content["tests"]
	var keys = yaml_tests.keys()
	if keys.empty():
		return null

	var parsed_tests = []
	for key in keys:
		parsed_tests.append(parse_test_data(key, yaml_tests[key]))

	return parsed_tests


func parse_test_data(name: String, yaml_content: Dictionary) -> TypingExercise:
	var keys = yaml_content.keys()

	if !keys.has("content"):
		return null

	var exercise = TypingExercise.new(name, yaml_content["content"] as PoolStringArray)

	if keys.has("qwertz"):
		exercise.qwertz = yaml_content["qwertz"]

	return exercise
