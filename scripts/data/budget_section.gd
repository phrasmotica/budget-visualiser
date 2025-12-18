@tool
class_name BudgetSection
extends Resource

@export
var name := "":
	set(value):
		name = value

		emit_changed()

@export
var categories: Array[BudgetCategory] = []:
	set(value):
		categories = value

		for c in categories:
			SignalHelper.on_changed(c, emit_changed)

		emit_changed()

func get_category_index(category: BudgetCategory) -> int:
	return categories.find(category)

func get_category(index: int) -> BudgetCategory:
	return categories[index]
