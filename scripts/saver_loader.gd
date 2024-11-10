extends Node

const SAVE_FILE_FORMAT: String = "user://budget-%d.tres"

signal loaded_data(data: SaveData)

func save_data(data: SaveData) -> bool:
    var file_name = SAVE_FILE_FORMAT % data.id
    ResourceSaver.save(data, file_name)

    print("Saved " + data.name + " budget data to " + file_name)

    return true

func load_data() -> SaveData:
    var files := DirAccess.get_files_at("user://")

    var file_name := ""

    # TODO: allow the user to choose which budget to load, rather than always
    # loading the first one
    for f in files:
        if f.begins_with("budget-"):
            file_name = f
            break

    if len(file_name) <= 0:
        print("No saved data to load!")
        return null

    var data: SaveData = ResourceLoader.load("user://" + file_name)

    print("Loaded " + data.name + " budget data from " + file_name)

    return data

func _on_app_app_open() -> void:
    var data := load_data()

    if data:
        loaded_data.emit(data)

func _on_ui_created_save_data(data: SaveData) -> void:
    var success := save_data(data)
    if success:
        print("Saved data successfully!")

func _on_ui_requested_load() -> void:
    var data := load_data()

    if data:
        loaded_data.emit(data)
