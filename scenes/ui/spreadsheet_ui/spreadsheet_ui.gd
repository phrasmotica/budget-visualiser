class_name SpreadsheetUI
extends Node

enum State { IDLE, DISABLED }

@onready
var year_grid: YearGrid = %YearGrid

@onready
var amount_entry_modal: AmountEntryModal = %AmountEntryModal

@onready
var transaction_lister_modal: TransactionListerModal = %TransactionListerModal

var _state_factory := SpreadsheetUIStateFactory.new()
var _current_state: SpreadsheetUIState = null

func _ready() -> void:
	BudgetManager.load_or_create()

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
