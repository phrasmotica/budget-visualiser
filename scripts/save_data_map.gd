class_name SaveDataMap

var _data_map := {}

func add_record(data: SaveData) -> SaveData:
    _data_map[data.id] = data

    print("Added data ID=%d to save data map, now has %d object(s)" % [data.id, size()])

    return _data_map[data.id]

func get_record(id: int) -> SaveData:
    return _data_map[id] if record_exists(id) else null

func get_or_add_record(id: int) -> SaveData:
    if record_exists(id):
        return get_record(id)

    var new_record := SaveData.new()
    new_record.id = id

    return add_record(new_record)

func record_exists(id: int) -> bool:
    return _data_map.has(id)

func size() -> int:
    return _data_map.size()

func rename(id: int, new_name: String) -> SaveData:
    if not record_exists(id):
        print("Could not rename save data record ID=%d, does not exist!" % id)
        return null

    _data_map[id].name = new_name

    return get_record(id)

func delete_record(id: int) -> bool:
    if not record_exists(id):
        print("Could not delete save data record ID=%d, does not exist!" % id)
        return false

    _data_map.erase(id)

    print("Deleted record ID=%d from save data map, now has %d object(s)" % [id, size()])

    return true
