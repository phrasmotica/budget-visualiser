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

func get_remaining() -> float:
    return total_budget - get_spent() - get_bills_spent()

func get_spent() -> float:
    if transactions_disabled:
        return 0.0

    var enabled_transactions := transactions.filter(transaction_is_enabled)
    return enabled_transactions.map(func(t): return t.amount).reduce(sumf, 0)

func get_bills_spent() -> float:
    if bills_disabled:
        return 0.0

    var enabled_bills := bills.filter(transaction_is_enabled)
    return enabled_bills.map(func(t): return t.amount).reduce(sumf, 0)

func transaction_is_enabled(t: Transaction):
    return not t.disabled

func sumf(accum: float, next: float):
    return accum + next
