class_name TransactionListerModalState
extends Node

signal state_transition_requested(new_state: TransactionListerModal.State, state_data: TransactionListerModalStateData)

var _transaction_lister_modal: TransactionListerModal = null
var _state_data: TransactionListerModalStateData = null

func setup(
	transaction_lister_modal: TransactionListerModal,
	state_data: TransactionListerModalStateData,
) -> void:
	_transaction_lister_modal = transaction_lister_modal
	_state_data = state_data

func transition_state(
	new_state: TransactionListerModal.State,
	state_data := TransactionListerModalStateData.new(),
) -> void:
	state_transition_requested.emit(new_state, state_data)
