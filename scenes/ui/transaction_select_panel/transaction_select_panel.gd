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

@onready
var label: Label = %Label

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
	if label:
		if transaction:
			label.text = Strings.curr(transaction.amount)
		else:
			label.text = "???"

		if transaction and not transaction.hidden:
			label.label_settings.font_color = Color.WHITE
		else:
			label.label_settings.font_color = Color.DIM_GRAY

func highlight() -> void:
	if _current_state:
		_current_state.highlight()

func unhighlight() -> void:
	if _current_state:
		_current_state.unhighlight()
