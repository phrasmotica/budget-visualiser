class_name YearGridStateDisabled
extends YearGridState

func _enter_tree() -> void:
	print("%s is now disabled" % _year_grid.name)

	_year_grid.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED

	_month_grid_manager.pause()

	SignalHelper.once(
		AmountEvents.entry_finished,
		_on_entry_finished
	)

func _on_entry_finished(amount: float) -> void:
	var state_data := YearGridStateData.build() \
		.with_entered_amount(amount)

	transition_state(YearGrid.State.IDLE, state_data)
