extends Node

const SAVE_FILE_FORMAT: String = "user://budget-%d.tres"

signal saved_data(data: BudgetData)

func load_latest_budget() -> BudgetData:
	var budget_files := _get_existing_budgets()

	if budget_files.size() <= 0:
		print("No saved data to load!")
		return null

	budget_files.sort_custom(_sort_by_recent)

	return _load_data(budget_files[0])

func save_budget_data(data: BudgetData) -> void:
	var success := _save_data(data)
	if success:
		print("Saved data successfully!")

		saved_data.emit(data)

func _get_existing_budgets() -> Array[String]:
	var files := DirAccess.get_files_at("user://")

	var budget_files: Array[String] = []

	for f in files:
		if f.begins_with("budget-"):
			budget_files.append(f)

	return budget_files

func _save_data(data: BudgetData) -> bool:
	var file_name = SAVE_FILE_FORMAT % data.id
	ResourceSaver.save(data, file_name)

	print("Saved budget data to %s" % file_name)

	return true

func _load_data(file_name: String) -> BudgetData:
	var path := "user://" + file_name

	if not FileAccess.file_exists(path):
		print("Budget file %s does not exist!" % file_name)
		return null

	var data: BudgetData = ResourceLoader.load(path)

	print("Loaded budget data from %s" % file_name)

	return data

func _sort_by_recent(file_name_1: String, file_name_2: String) -> bool:
	return \
		FileAccess.get_modified_time("user://" + file_name_1) > \
		FileAccess.get_modified_time("user://" + file_name_2)
