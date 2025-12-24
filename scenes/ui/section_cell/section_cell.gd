class_name SectionCell
extends MarginContainer

@onready
var category_cell: CategoryCell = %CategoryCell

func inject_amount(amount: float) -> void:
	if category_cell:
		category_cell.inject_amount(amount)
