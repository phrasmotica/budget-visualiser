class_name IncomeGridStateIdle
extends IncomeGridState

func _enter_tree() -> void:
	Logger.debug("%s is now idle" % _income_grid.name)

	SignalHelper.persist(
		BudgetProvider.budget_changed,
		_on_budget_changed
	)

	_update_totals()

func _on_budget_changed(_data: BudgetData) -> void:
	_update_totals()

func _update_totals() -> void:
	_section_cell_manager.update_amounts(_income_grid.section)
