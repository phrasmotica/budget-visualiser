class_name TransactionListerState
extends Node

signal state_transition_requested(new_state: TransactionLister.State, state_data: TransactionListerStateData)

var _transaction_lister: TransactionLister = null
var _state_data: TransactionListerStateData = null
var _appearance: TransactionListerAppearance = null
var _transaction_panel_manager: TransactionPanelManager = null
var _finished_button: ButtonPanel = null
var _index_tracker: IndexTracker = null

func setup(
	transaction_lister: TransactionLister,
	state_data: TransactionListerStateData,
	appearance: TransactionListerAppearance,
	transaction_panel_manager: TransactionPanelManager,
	finished_button: ButtonPanel,
	index_tracker: IndexTracker,
) -> void:
	_transaction_lister = transaction_lister
	_state_data = state_data
	_appearance = appearance
	_transaction_panel_manager = transaction_panel_manager
	_finished_button = finished_button
	_index_tracker = index_tracker

func transition_state(
	new_state: TransactionLister.State,
	state_data := TransactionListerStateData.new(),
) -> void:
	state_transition_requested.emit(new_state, state_data)
