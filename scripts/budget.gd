@tool
class_name Budget extends Resource

@export
var id: int = -1

@export
var name := "":
    set(value):
        name = value

        handle_property_change_from_editor()

@export
var transactions: Array[Transaction] = []:
    set(value):
        transactions = value

        handle_property_change_from_editor()

@export
var transactions_disabled := false:
    set(value):
        transactions_disabled = value

        handle_property_change_from_editor()

@export
var bills: Array[Transaction] = []:
    set(value):
        bills = value

        handle_property_change_from_editor()

@export
var bills_disabled := false:
    set(value):
        bills_disabled = value

        handle_property_change_from_editor()

@export
var total_budget: float = 0:
    set(value):
        total_budget = value

        handle_property_change_from_editor()

func handle_property_change_from_editor() -> void:
    if Engine.is_editor_hint():
        emit_changed()

func set_budget_name(new_name: String, emit: bool) -> void:
    name = new_name

    if emit:
        emit_changed()
