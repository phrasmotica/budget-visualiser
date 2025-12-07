class_name SpreadsheetUIStateIdle
extends SpreadsheetUIState

func _enter_tree() -> void:
	print("%s is now idle" % _spreadsheet_ui.name)

	_year_grid.enable()

	_amount_entry_modal.disable()

	SignalHelper.once_next_frame(_inject_entered_amount)

	SignalHelper.persist(
		BudgetProvider.transaction_added,
		_on_transaction_added
	)

	SignalHelper.persist(
		BudgetProvider.budget_changed,
		_on_budget_changed
	)

func _process(_delta: float) -> void:
	if Input.is_action_just_released("ui_accept"):
		_show_modal()

func _inject_entered_amount() -> void:
	var entered_amount := _state_data.get_entered_amount()
	if entered_amount > 0.0:
		var category := _year_grid.get_highlighted_category()
		var month := _year_grid.get_highlighted_month()

		BudgetProvider.add_transaction(category, month, entered_amount)

func _on_transaction_added(transaction: BudgetTransaction) -> void:
	print("New transaction: %s %s, £%.2f" % [
		transaction.month.name,
		transaction.category.name,
		transaction.amount,
	])

	var month := transaction.month
	var budget_data := BudgetProvider.get_budget_data()

	print("%s Total: £%.2f" % [
		month.name,
		budget_data.compute_month_expenditure(month)
	])

func _on_budget_changed(data: BudgetData) -> void:
	print("Grand Total: £%.2f" % data.compute_total_expenditure())

	_year_grid.update_budget(data)

func _show_modal() -> void:
	var category := _year_grid.get_highlighted_category()
	var month := _year_grid.get_highlighted_month()
	var starting_amount := BudgetProvider.get_amount(category, month)

	_amount_entry_modal.enable(category, month, 0.0, starting_amount)

	transition_state(SpreadsheetUI.State.DISABLED)
