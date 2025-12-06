class_name MonthGridStateDisabled
extends MonthGridState

func _enter_tree() -> void:
	print("%s is now disabled" % _month_grid.name)

	_month_grid.theme_type_variation = "IdleMonthGridContainer"

	if _cell_manager.count() > 0:
		_cell_manager.dim(_index_tracker.current())

func enable() -> void:
	transition_state(MonthGrid.State.IDLE)
