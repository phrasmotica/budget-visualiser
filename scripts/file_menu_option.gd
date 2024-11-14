@tool
class_name FileMenuOption extends TextureRect

@export
var option_text := "New"

@export
var input: StringName = "":
    set(value):
        input = value
        update_configuration_warnings()

func _ready():
    if Engine.is_editor_hint():
        InputMap.load_from_project_settings()

func _get_configuration_warnings() -> PackedStringArray:
    if not InputMap.has_action(input):
        return ["The input '%s' does not exist!" % input]

    return []
