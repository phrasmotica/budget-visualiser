class_name SpreadsheetUIStateDisabled
extends SpreadsheetUIState

const MAPPING_CONTEXT: GUIDEMappingContext = preload(
	"res://resources/input/ctx_spreadsheet_ui_disabled.tres")

func _enter_tree() -> void:
	Logger.debug("%s is now disabled" % _spreadsheet_ui.name)

	GUIDE.enable_mapping_context(MAPPING_CONTEXT)

	_year_grid.disable()

	SignalHelper.once(
		TransactionListerEvents.cancelled,
		_on_entry_cancelled
	)

	SignalHelper.once(
		AmountEvents.entry_cancelled,
		_on_entry_cancelled
	)

	SignalHelper.once(
		AmountEvents.entry_finished,
		_on_entry_finished
	)

func _exit_tree() -> void:
	GUIDE.disable_mapping_context(MAPPING_CONTEXT)

func _on_entry_cancelled() -> void:
	transition_state(SpreadsheetUI.State.IDLE)

func _on_entry_finished(amount: float) -> void:
	var state_data := SpreadsheetUIStateData.build() \
		.with_entered_amount(amount)

	transition_state(SpreadsheetUI.State.IDLE, state_data)
