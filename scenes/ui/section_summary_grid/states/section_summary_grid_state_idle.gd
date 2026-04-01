class_name SectionSummaryGridStateIdle
extends SectionSummaryGridState

func _enter_tree() -> void:
	CustomLogger.debug("%s is now idle" % _section_summary_grid.name)

	SignalHelper.persist(
		BudgetProvider.budget_changed,
		_on_budget_changed
	)

	_update_totals()

func _on_budget_changed(_data: BudgetData) -> void:
	_update_totals()

func _update_totals() -> void:
	_section_cell_manager.update_amounts(_section_summary_grid.section)
