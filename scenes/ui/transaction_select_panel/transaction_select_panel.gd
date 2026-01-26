@tool
class_name TransactionSelectPanel
extends PanelContainer

enum State { IDLE, HIGHLIGHTED }

@export
var transaction: BudgetTransaction:
	set(value):
		transaction = value

		SignalHelper.on_changed(transaction, _refresh)

		_refresh()

@export
var show_as_hidden := false:
	set(value):
		show_as_hidden = value

		_refresh()

@onready
var amount_label: AmountLabel = %AmountLabel

@onready
var unhidden_icon: TextureRect = %UnhiddenIcon

@onready
var hidden_icon: TextureRect = %HiddenIcon

var _state_factory := TransactionSelectPanelStateFactory.new()
var _current_state: TransactionSelectPanelState = null

func _ready() -> void:
	_refresh()

	if Engine.is_editor_hint():
		return

	switch_state(TransactionSelectPanel.State.IDLE)

func switch_state(state: State, state_data := TransactionSelectPanelStateData.new()) -> void:
	if _current_state != null:
		_current_state.queue_free()

	_current_state = _state_factory.get_fresh_state(state)

	_current_state.setup(
		self,
		state_data)

	_current_state.state_transition_requested.connect(switch_state)
	_current_state.name = "TransactionSelectPanelStateMachine: %s" % str(state)

	call_deferred("add_child", _current_state)

func _refresh() -> void:
	if amount_label:
		amount_label.amount = transaction.amount if transaction else 0.0
		amount_label.show_as_unknown = transaction == null
		amount_label.show_as_hidden = show_as_hidden

	if unhidden_icon:
		unhidden_icon.visible = not show_as_hidden

	if hidden_icon:
		hidden_icon.visible = show_as_hidden

func highlight() -> void:
	if _current_state:
		_current_state.highlight()

func unhighlight() -> void:
	if _current_state:
		_current_state.unhighlight()
