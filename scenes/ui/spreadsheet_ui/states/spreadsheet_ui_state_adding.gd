class_name SpreadsheetUIStateAdding
extends SpreadsheetUIState

func _enter_tree() -> void:
	Logger.debug("%s is now adding" % _spreadsheet_ui.name)

	_header_panel.show_icons = false

	_year_grid.enable()

	_amount_entry_modal.disable()
	_transaction_lister_modal.disable()

	# allows time for the the year grid and its children to become highlighted
	# TODO: find a way of doing the update in the current frame?
	SignalHelper.once_next_frame(_inject_entered_amount)

func _inject_entered_amount() -> void:
	var entered_amount := _state_data.get_entered_amount()

	if entered_amount > 0.0:
		var category := _year_grid.get_highlighted_category()
		var month := _year_grid.get_highlighted_month()

		# TODO: this call should really be done as soon as the new transaction
		# is confirmed in the amount entry modal...
		BudgetProvider.add_transaction(category, month, entered_amount)

		_year_grid.update_budget(BudgetProvider.get_budget_data())

	transition_state(SpreadsheetUI.State.IDLE)
