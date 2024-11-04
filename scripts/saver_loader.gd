extends Node

const SAVE_FILE: String = "user://savedata.tres"

signal loaded_data(data: SaveData)

func save_data(data: SaveData) -> bool:
    ResourceSaver.save(data, SAVE_FILE)

    print("Saved budget data to " + SAVE_FILE)

    return true

func load_data() -> SaveData:
    if not FileAccess.file_exists(SAVE_FILE):
        print("No saved data to load!")
        return null

    var data: SaveData = ResourceLoader.load(SAVE_FILE)

    print("Loaded saved budget data from " + SAVE_FILE)

    return data

func _on_app_app_open() -> void:
    var data := load_data()

    if data:
        loaded_data.emit(data)

func _on_ui_created_save_data(data: SaveData) -> void:
    var success := save_data(data)
    if success:
        print("Saved data successfully!")
