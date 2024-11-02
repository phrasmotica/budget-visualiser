@tool
class_name Transaction extends Resource

@export
var id: int = -1

@export
var name := "":
    set(value):
        name = value

        handle_property_change_from_editor()

@export
var amount: float = 0:
    set(value):
        amount = value

        handle_property_change_from_editor()

func handle_property_change_from_editor() -> void:
    if Engine.is_editor_hint():
        emit_changed()

func set_transaction_name(new_name: String, emit: bool) -> void:
    name = new_name

    if emit:
        emit_changed()
