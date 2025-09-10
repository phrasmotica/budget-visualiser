class_name YearGridStateDisabled
extends YearGridState

func _enter_tree() -> void:
	print("%s is now disabled" % _year_grid.name)

	_month_grid_manager.pause()

	SignalHelper.once(
		AmountEvents.entry_finished,
		_on_entry_finished
	)

func _on_entry_finished(_amount: float) -> void:
	transition_state(YearGrid.State.IDLE)
