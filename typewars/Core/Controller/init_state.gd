class_name InitState
extends State


func enter() -> void:
	.enter()
	initialize()


func initialize() -> void:
	owner.data_loader = YamlDataLoader.new()
	owner.validator = Validator.new()
	owner.add_child(owner.data_loader)
	owner.add_child(owner.validator)

	owner.data_loader.connect("data_loaded", self, "on_data_loaded")
	owner.data_loader.load_data(owner.test_path)
	yield(owner.data_loader, "data_loaded")
	owner.change_state("SelectTestState")


func on_data_loaded(error: int, data: Array) -> void:
	if error != 0:
		print("Error loading data with error code: ", error)
		return
	var loaded_tests = {}
	for test in data:
		print(test.name)
		loaded_tests[test.name] = test
	owner.test_list = loaded_tests