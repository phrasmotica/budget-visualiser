@tool
class_name SectionCellManager
extends Node

@export
var cells: Array[SectionCell] = []

var _section_summariser: SectionSummariser = null

func update_amounts(section: BudgetSection) -> void:
	_section_summariser = SectionSummariser.new(section)

	for i in cells.size():
		# TODO: attach a specific month to each cell
		var month := BudgetProvider.BUDGET_MONTHS[i]
		var section_total := _section_summariser.compute_total(month)

		cells[i].inject_amount(section_total)
