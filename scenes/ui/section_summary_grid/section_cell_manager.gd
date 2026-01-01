@tool
class_name SectionCellManager
extends Node

@export
var cells: Array[SectionCell] = []

var _section_summariser: SectionSummariser = null

func update_amounts(section: BudgetSection) -> void:
	_section_summariser = SectionSummariser.new(section)

	for i in cells.size():
		var cell := cells[i]

		var section_total := _section_summariser.compute_total(cell.month)
		cell.inject_amount(section_total)
