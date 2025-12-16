@tool
class_name TransactionLister
extends VBoxContainer

enum State { DISABLED, ENABLED }

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

var _state_factory := TransactionListerStateFactory.new()
var _current_state: TransactionListerState = null

var _index_tracker: IndexTracker = null

func _ready() -> void:
	_refresh()

	if Engine.is_editor_hint():
		return

	switch_state(TransactionLister.State.DISABLED)

func switch_state(state: State, state_data := TransactionListerStateData.new()) -> void:
	if _current_state != null:
		_current_state.queue_free()

	_current_state = _state_factory.get_fresh_state(state)

	_current_state.setup(
		self,
		state_data,
		appearance,
		transaction_panel_manager,
		_index_tracker)

	_current_state.state_transition_requested.connect(switch_state)
	_current_state.name = "TransactionListerStateMachine: %s" % str(state)

	call_deferred("add_child", _current_state)

func _refresh() -> void:
	_index_tracker = IndexTracker.new(
		transactions.size() - 1,
		"TransactionListerIndexTracker")

	if appearance:
		appearance.refresh_panels(self, transactions)

func enable() -> void:
	if _current_state:
		_current_state.enable()

func disable() -> void:
	if _current_state:
		_current_state.disable()
