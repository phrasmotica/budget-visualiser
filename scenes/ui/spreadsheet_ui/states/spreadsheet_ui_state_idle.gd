class_name SpreadsheetUIStateIdle
extends SpreadsheetUIState

func _enter_tree() -> void:
	print("%s is now idle" % _spreadsheet_ui.name)

	_year_grid.enable()

	_amount_entry_modal.disable()

	SignalHelper.once_next_frame(_inject_entered_amount)

	BudgetProvider.set_budget_data(BudgetData.new())

	SignalHelper.persist(
		BudgetProvider.transaction_added,
		_on_transaction_added
	)

func _process(_delta: float) -> void:
	if Input.is_action_just_released("ui_cancel"):
		_add_transaction()

	# if Input.is_action_just_released("ui_accept"):
	# 	_show_modal()

func _inject_entered_amount() -> void:
	var entered_amount := _state_data.get_entered_amount()
	_year_grid.inject_amount(entered_amount)

func _on_transaction_added(transaction: BudgetTransaction) -> void:
	print("New transaction: %s %s, £%.2f" % [
		transaction.month.name,
		transaction.category.name,
		transaction.amount,
	])

func _add_transaction() -> void:
	# [1.0, 5.0]
	var amount := 4.0 * randf() + 1.0

	BudgetProvider.add_transaction_debug(amount)

func _show_modal() -> void:
	_amount_entry_modal.enable(0.0)

	transition_state(SpreadsheetUI.State.DISABLED)
