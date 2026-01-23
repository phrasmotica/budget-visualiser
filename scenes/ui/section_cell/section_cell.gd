class_name SectionCell
extends MarginContainer

@export
var month: BudgetMonth

@onready
var amount_cell: AmountCell = %AmountCell

func inject_amount(amount: float) -> void:
	if amount_cell:
		amount_cell.inject_amount(amount)
