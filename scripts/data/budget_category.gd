@tool
class_name BudgetCategory
extends Resource

@export
var name := "":
	set(value):
		name = value

		emit_changed()
