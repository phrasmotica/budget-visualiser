@tool
class_name BudgetSection
extends Resource

@export
var name := "":
	set(value):
		name = value

		emit_changed()
