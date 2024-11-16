class_name SaverLoader extends Node

const SAVE_FILE_FORMAT: String = "user://budget-%d.tres"

signal existing_data_read(file_names: Array[String])
signal loaded_data(data: SaveData)

func get_existing_budgets() -> Array[String]:
    var files := DirAccess.get_files_at("user://")

    var budget_files: Array[String] = []

    for f in files:
        if f.begins_with("budget-"):
            budget_files.append(f)

    return budget_files

func save_data(data: SaveData) -> bool:
    var file_name = SAVE_FILE_FORMAT % data.id
    ResourceSaver.save(data, file_name)

    print("Saved " + data.name + " budget data to " + file_name)

    return true

func load_data(file_name: String) -> SaveData:
    var path := "user://" + file_name

    if not FileAccess.file_exists(path):
        print("Budget file %s does not exist!" % file_name)
        return null

    var data: SaveData = ResourceLoader.load(path)

    print("Loaded " + data.name + " budget data from " + file_name)

    return data

func _on_app_app_open() -> void:
    var files := DirAccess.get_files_at("user://")

    var budget_files: Array[String] = []

    for f in files:
        if f.begins_with("budget-"):
            budget_files.append(f)

    budget_files.sort_custom(
        func(s: String, t: String):
            return FileAccess.get_modified_time("user://" + s) > FileAccess.get_modified_time("user://" + t)
    )

    if budget_files.size() <= 0:
        print("No saved data to load!")
        return

    var data := load_data(budget_files[0])

    if data:
        loaded_data.emit(data)

func _on_ui_created_save_data(data: SaveData, is_new: bool) -> void:
    var success := save_data(data)
    if success:
        print("Saved data successfully!")

    if is_new:
        print("Opening new save data " + data.name)

func _on_ui_requested_load(file_name: String) -> void:
    var data := load_data(file_name)

    if data:
        loaded_data.emit(data)

func _on_ui_existing_data_requested() -> void:
    var file_names := get_existing_budgets()
    existing_data_read.emit(file_names)
