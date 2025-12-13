class_name TransactionSelectPanelState
extends Node

signal state_transition_requested(new_state: TransactionSelectPanel.State, state_data: TransactionSelectPanelStateData)

var _transaction_select_panel: TransactionSelectPanel = null
var _state_data: TransactionSelectPanelStateData = null

func setup(
	transaction_select_panel: TransactionSelectPanel,
	state_data: TransactionSelectPanelStateData,
) -> void:
	_transaction_select_panel = transaction_select_panel
	_state_data = state_data

func transition_state(
	new_state: TransactionSelectPanel.State,
	state_data := TransactionSelectPanelStateData.new(),
) -> void:
	state_transition_requested.emit(new_state, state_data)

func highlight() -> void:
	pass

func unhighlight() -> void:
	pass
