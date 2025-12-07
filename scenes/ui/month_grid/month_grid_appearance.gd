@tool
class_name MonthGridAppearance
extends Node

const CELL_SCENE := preload("res://scenes/ui/category_cell/category_cell.tscn")

@export
var cell_manager: CellManager

@export
var cell_parent: VBoxContainer

func refresh_cells(cell_owner: Control, categories: Array[BudgetCategory]) -> void:
	var category_count := categories.size()
	var child_count := cell_parent.get_child_count()

	if cell_manager:
		cell_manager.cells.clear()

	for i in category_count:
		var cell: CategoryCell

		if i >= child_count:
			cell = CELL_SCENE.instantiate()
			cell.name = "CategoryCell%d" % i

			cell_parent.add_child(cell)
			cell.owner = cell_owner
		else:
			cell = cell_parent.get_child(i)

		if cell_manager:
			cell_manager.cells.append(cell)

	while cell_parent.get_child_count() > category_count:
		var child := cell_parent.get_child(category_count)
		cell_parent.remove_child(child)
