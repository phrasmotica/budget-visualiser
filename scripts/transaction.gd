@tool
class_name Transaction extends Resource

@export
var id: int = -1

@export
var name := "":
    set(value):
        name = value
        emit_changed()

@export
var amount: float = 0:
    set(value):
        amount = value
        emit_changed()
