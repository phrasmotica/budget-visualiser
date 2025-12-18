class_name YearGridStateDisabled
extends YearGridState

func _enter_tree() -> void:
	Logger.debug("%s is now disabled" % _year_grid.name)

	_month_grid_manager.pause()

func update_budget(data: BudgetData) -> void:
	_month_grid_manager.inject_budget(data)

func enable() -> void:
	transition_state(YearGrid.State.IDLE)
