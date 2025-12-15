class_name TransactionListerModalState
extends Node

signal state_transition_requested(new_state: TransactionListerModal.State, state_data: TransactionListerModalStateData)

var _transaction_lister_modal: TransactionListerModal = null
var _state_data: TransactionListerModalStateData = null
var _transaction_lister: TransactionLister = null

func setup(
	transaction_lister_modal: TransactionListerModal,
	state_data: TransactionListerModalStateData,
	transaction_lister: TransactionLister,
) -> void:
	_transaction_lister_modal = transaction_lister_modal
	_state_data = state_data
	_transaction_lister = transaction_lister

func transition_state(
	new_state: TransactionListerModal.State,
	state_data := TransactionListerModalStateData.new(),
) -> void:
	state_transition_requested.emit(new_state, state_data)

func enable(_transactions: Array[BudgetTransaction]) -> void:
	pass

func disable() -> void:
	pass
