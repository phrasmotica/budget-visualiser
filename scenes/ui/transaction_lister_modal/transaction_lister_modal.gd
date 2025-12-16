@tool
class_name TransactionListerModal
extends Control

enum State { HIDDEN, ACTING, FINISHING }

@export
var sub_header := "":
	set(value):
		sub_header = value

		_refresh()

@onready
var sub_header_label: Label = %SubHeaderLabel

@onready
var transaction_lister: TransactionLister = %TransactionLister

@onready
var modal_buttons: ModalButtons = %ModalButtons

var _state_factory := TransactionListerModalStateFactory.new()
var _current_state: TransactionListerModalState = null

func _ready() -> void:
	_refresh()

	if Engine.is_editor_hint():
		return

	switch_state(State.HIDDEN)

func switch_state(state: State, state_data := TransactionListerModalStateData.new()) -> void:
	if _current_state != null:
		_current_state.queue_free()

	_current_state = _state_factory.get_fresh_state(state)

	_current_state.setup(
		self,
		state_data,
		transaction_lister,
		modal_buttons)

	_current_state.state_transition_requested.connect(switch_state)
	_current_state.name = "TransactionListerModalStateMachine: %s" % str(state)

	call_deferred("add_child", _current_state)

func _refresh() -> void:
	if sub_header_label:
		sub_header_label.text = sub_header

func enable(transactions: Array[BudgetTransaction]) -> void:
	if _current_state:
		_current_state.enable(transactions)

func disable() -> void:
	if _current_state:
		_current_state.disable()
