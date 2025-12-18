@tool
class_name SpreadsheetUI
extends PanelContainer

enum State { IDLE, DISABLED }

@export
var budget_section: BudgetSection:
	set(value):
		budget_section = value

		SignalHelper.on_changed(budget_section, _refresh)

		_refresh()

@onready
var header_panel: HeaderPanel = %HeaderPanel

@onready
var year_grid: YearGrid = %YearGrid

@onready
var amount_entry_modal: AmountEntryModal = %AmountEntryModal

@onready
var transaction_lister_modal: TransactionListerModal = %TransactionListerModal

var _state_factory := SpreadsheetUIStateFactory.new()
var _current_state: SpreadsheetUIState = null

func _ready() -> void:
	_refresh()

	if Engine.is_editor_hint():
		return

	BudgetManager.load_or_create()

	budget_section = BudgetProvider.get_section()

	switch_state(SpreadsheetUI.State.IDLE)

func switch_state(state: State, state_data := SpreadsheetUIStateData.new()) -> void:
	if _current_state != null:
		_current_state.queue_free()

	_current_state = _state_factory.get_fresh_state(state)

	_current_state.setup(
		self,
		state_data,
		year_grid,
		amount_entry_modal,
		transaction_lister_modal)

	_current_state.state_transition_requested.connect(switch_state)
	_current_state.name = "SpreadsheetUIStateMachine: %s" % str(state)

	call_deferred("add_child", _current_state)

func _refresh() -> void:
	if header_panel:
		header_panel.text = budget_section.name if budget_section else "Budget"

	if year_grid:
		year_grid.section = budget_section
