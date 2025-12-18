class_name SpreadsheetUIStateIdle
extends SpreadsheetUIState

func _enter_tree() -> void:
	Logger.debug("%s is now idle" % _spreadsheet_ui.name)

	GuideHelper.enable_primary_modifier()
	GuideHelper.enable_grid_movement()

	_header_panel.show_icons = false

	_year_grid.enable()

	_amount_entry_modal.disable()
	_transaction_lister_modal.disable()

	SignalHelper.once_next_frame(_inject_entered_amount)

	SignalHelper.persist(
		ModifierInput.primary_modifier_pressed,
		_on_primary_modifier_pressed
	)

	SignalHelper.persist(
		ModifierInput.primary_modifier_released,
		_on_primary_modifier_released
	)

	SignalHelper.persist(
		PageInput.move_end,
		_on_move_end
	)

	SignalHelper.persist(
		PageInput.move_start,
		_on_move_start
	)

	SignalHelper.persist(
		BudgetProvider.transaction_added,
		_on_transaction_added
	)

	SignalHelper.persist(
		BudgetProvider.budget_changed,
		_on_budget_changed
	)

	_year_grid.update_budget(BudgetProvider.get_budget_data())

func _on_primary_modifier_pressed() -> void:
	_header_panel.show_icons = true

	_year_grid.disable()

func _on_primary_modifier_released() -> void:
	_header_panel.show_icons = false

	_year_grid.enable()

func _process(_delta: float) -> void:
	if Input.is_action_just_released("ui_accept"):
		_show_modal()

	if Input.is_action_just_released("show_transaction_lister"):
		_show_transaction_lister_modal()

func _inject_entered_amount() -> void:
	var entered_amount := _state_data.get_entered_amount()
	if entered_amount > 0.0:
		var category := _year_grid.get_highlighted_category()
		var month := _year_grid.get_highlighted_month()

		BudgetProvider.add_transaction(category, month, entered_amount)

func _on_move_end() -> void:
	var next_section := BudgetProvider.next_section()
	_spreadsheet_ui.budget_section = next_section

func _on_move_start() -> void:
	var previous_section := BudgetProvider.previous_section()
	_spreadsheet_ui.budget_section = previous_section

func _on_transaction_added(transaction: BudgetTransaction) -> void:
	Logger.info("New transaction: %s %s, %s" % [
		transaction.month.name,
		transaction.category.name,
		Strings.curr(transaction.amount),
	])

	var month := transaction.month
	var budget_data := BudgetProvider.get_budget_data()

	Logger.info("%s Total: %s" % [
		month.name,
		Strings.curr(budget_data.compute_month_expenditure(month))
	])

func _on_budget_changed(data: BudgetData) -> void:
	Logger.info("Grand Total: %s" % Strings.curr(data.compute_total_expenditure()))

	_year_grid.update_budget(data)

func _show_modal() -> void:
	var category := _year_grid.get_highlighted_category()
	var month := _year_grid.get_highlighted_month()
	var starting_amount := BudgetProvider.get_amount(category, month)

	_amount_entry_modal.enable(category, month, 0.0, starting_amount)

	transition_state(SpreadsheetUI.State.DISABLED)

func _show_transaction_lister_modal() -> void:
	var category := _year_grid.get_highlighted_category()
	var month := _year_grid.get_highlighted_month()

	var budget_data := BudgetProvider.get_budget_data()
	var transactions := budget_data.get_transactions_for_category_and_month(
		category,
		month)

	if transactions.size() <= 0:
		Logger.info("No transactions to list!")
		return

	_transaction_lister_modal.sub_header = "%s - %s" % [category.name, month.name]
	_transaction_lister_modal.enable(transactions)

	transition_state(SpreadsheetUI.State.DISABLED)
