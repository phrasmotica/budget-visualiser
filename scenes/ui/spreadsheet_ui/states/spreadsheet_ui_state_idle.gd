class_name SpreadsheetUIStateIdle
extends SpreadsheetUIState

const MAPPING_CONTEXT: GUIDEMappingContext = preload(
	"res://resources/input/ctx_spreadsheet_ui_idle.tres")

func _enter_tree() -> void:
	Logger.debug("%s is now idle" % _spreadsheet_ui.name)

	GUIDE.enable_mapping_context(MAPPING_CONTEXT)

	_header_panel.show_icons = false

	_year_grid.enable()

	_amount_entry_modal.disable()
	_transaction_lister_modal.disable()

	SignalHelper.persist(ConfirmCancelInput.confirm, _show_modal)

	SignalHelper.persist(
		ModalInput.transaction_lister_modal_requested,
		_show_transaction_lister_modal)

	SignalHelper.persist(
		ModifierInput.primary_modifier_pressed,
		_on_primary_modifier_pressed
	)

	_year_grid.update_budget(BudgetProvider.get_budget_data())

func _exit_tree() -> void:
	GUIDE.disable_mapping_context(MAPPING_CONTEXT)

func _on_primary_modifier_pressed() -> void:
	transition_state(SpreadsheetUI.State.SWITCHING)

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
