class_name SpreadsheetUIStateDisabled
extends SpreadsheetUIState

func _enter_tree() -> void:
	print("%s is now disabled" % _spreadsheet_ui.name)

	_year_grid.disable()

	SignalHelper.once(
		AmountEvents.entry_finished,
		_on_entry_finished
	)

func _on_entry_finished(amount: float) -> void:
	var state_data := SpreadsheetUIStateData.build() \
		.with_entered_amount(amount)

	transition_state(SpreadsheetUI.State.IDLE, state_data)
