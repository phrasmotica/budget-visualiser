class_name SpreadsheetUIStateSwitching
extends SpreadsheetUIState

const MAPPING_CONTEXT: GUIDEMappingContext = preload(
	"res://resources/input/ctx_spreadsheet_ui_switching.tres")

func _enter_tree() -> void:
	Logger.debug("%s is now switching" % _spreadsheet_ui.name)

	GUIDE.enable_mapping_context(MAPPING_CONTEXT)

	_header_panel.show_icons = true

	_year_grid.disable()

	_amount_entry_modal.disable()
	_transaction_lister_modal.disable()

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

func _exit_tree() -> void:
	GUIDE.disable_mapping_context(MAPPING_CONTEXT)

func _on_primary_modifier_released() -> void:
	transition_state(SpreadsheetUI.State.IDLE)

func _on_move_end() -> void:
	var next_section := BudgetProvider.next_section()
	_spreadsheet_ui.budget_section = next_section

func _on_move_start() -> void:
	var previous_section := BudgetProvider.previous_section()
	_spreadsheet_ui.budget_section = previous_section
