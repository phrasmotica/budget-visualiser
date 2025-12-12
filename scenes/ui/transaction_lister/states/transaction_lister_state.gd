class_name TransactionListerState
extends Node

signal state_transition_requested(new_state: TransactionLister.State, state_data: TransactionListerStateData)

var _transaction_lister: TransactionLister = null
var _state_data: TransactionListerStateData = null

func setup(
	transaction_lister: TransactionLister,
	state_data: TransactionListerStateData,
) -> void:
	_transaction_lister = transaction_lister
	_state_data = state_data

func transition_state(
	new_state: TransactionLister.State,
	state_data := TransactionListerStateData.new(),
) -> void:
	state_transition_requested.emit(new_state, state_data)
