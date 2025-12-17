@tool
class_name BudgetTransaction
extends Resource

@export
var id := -1

@export
var category: BudgetCategory

@export
var month: BudgetMonth

@export
var amount := 0.0:
	set(value):
		amount = value

		emit_changed()

@export
var hidden := false:
	set(value):
		hidden = value

		emit_changed()
