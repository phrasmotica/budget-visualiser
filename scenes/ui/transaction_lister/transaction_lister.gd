@tool
class_name TransactionLister
extends VBoxContainer

enum State { DISABLED, ENABLED, FINISHING }

@export
var transactions: Array[BudgetTransaction] = []:
	set(value):
		transactions = value

		for t in transactions:
			SignalHelper.on_changed(t, _refresh)

		_refresh()

@onready
var appearance: TransactionListerAppearance = %Appearance

@onready
var transaction_panel_manager: TransactionPanelManager = %TransactionPanelManager

@onready
var finished_button: ButtonPanel = %FinishedButton

var _state_factory := TransactionListerStateFactory.new()
var _current_state: TransactionListerState = null

var _index_tracker: IndexTracker = null

func _ready() -> void:
	if Engine.is_editor_hint():
		return

	_index_tracker = IndexTracker.new(transaction_panel_manager.count() - 1)

	switch_state(TransactionLister.State.ENABLED)

func switch_state(state: State, state_data := TransactionListerStateData.new()) -> void:
	if _current_state != null:
		_current_state.queue_free()

	_current_state = _state_factory.get_fresh_state(state)

	_current_state.setup(
		self,
		state_data,
		appearance,
		transaction_panel_manager,
		finished_button,
		_index_tracker)

	_current_state.state_transition_requested.connect(switch_state)
	_current_state.name = "TransactionListerStateMachine: %s" % str(state)

	call_deferred("add_child", _current_state)

func _refresh() -> void:
	if appearance:
		appearance.refresh_panels(self, transactions)
