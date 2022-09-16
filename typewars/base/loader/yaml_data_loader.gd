class_name YamlDataLoader
extends Dataloader

var _yaml = preload("res://addons/godot-yaml/gdyaml.gdns").new()


func load_data(file_path: String) -> int:
	var file = File.new()
	var error = file.open(file_path, File.READ)
	if error != 0:
		print("Error opening file: " + file_path)
		return error

	var content = file.get_as_text()
	if content.empty():
		print("Error reading file: " + file_path)
		return ERR_INVALID_DATA

	var yaml_content = _yaml.parse(content).result[0]
	if !(yaml_content is Dictionary):
		print("Error parsing file: " + file_path)
		return ERR_INVALID_DATA

	var exercises = get_tests(yaml_content)
	emit_signal("data_loaded", exercises)
	return 0


func get_tests(yaml_content):
	if !yaml_content.has("tests"):  # || yaml_content["tests"].empty():
		return null

	var yaml_tests = yaml_content["tests"]
	var keys = yaml_tests.keys()
	if keys.empty():
		return null

	var parsed_tests = []
	for key in keys:
		parsed_tests.append(parse_test_data(key, yaml_tests[key]))

	return parsed_tests


func parse_test_data(name: String, yaml_content) -> TypingTest:
	var keys = yaml_content.keys()

	if !keys.has("content"):
		return null

	var content = yaml_content["content"]

	var test = _get_typing_test_class(content)
	test.name = name
	test.content = content

	if keys.has("qwertz"):
		test.qwertz = yaml_content["qwertz"]

	return test


func _get_typing_test_class(content) -> TypingTest:
	if content is String:
		return SequenceTypingTest.new()
	return TypingTest.new()
