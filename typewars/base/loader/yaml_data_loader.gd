class_name YamlDataLoader
extends Dataloader


var _yaml = preload("res://addons/godot-yaml/gdyaml.gdns").new()


func load_data(file_path: String) -> void:
	var file = File.new()
	var error = file.open(file_path, File.READ)

	if error != 0:
		print("Error opening file: " + file_path)
		emit_signal("data_loaded", error, null)

	var content = file.get_as_text()
	if content.empty():
		emit_signal("data_loaded", error, null)

	var yaml_content = _yaml.parse(content).result[0]
	if !(yaml_content is Dictionary):
		print("Error parsing file: " + file_path)
		emit_signal("data_loaded", error, null)

	var tests = create_test_data_from_raw(yaml_content)
	yield(get_tree(), "idle_frame")
	emit_signal("data_loaded", error, tests)


func create_test_data_from_raw(yaml_content):
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


func parse_test_data(name: String, yaml_content) -> RawTestData:
	var keys = yaml_content.keys()

	if !keys.has("content"):
		return null

	var content = yaml_content["content"]

	var test = RawTestData.new()
	test.name = name
	test.data = content
	return test