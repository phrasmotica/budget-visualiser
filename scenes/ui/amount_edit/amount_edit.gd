@tool
class_name AmountEdit
extends PanelContainer

const AMOUNT_MINIMUM := 0

enum State { IDLE, HIGHLIGHTED }

@export_range(10, 999)
var amount_maximum := 99:
	set(value):
		amount_maximum = value

		_refresh()

@onready
var appearance: AmountEditAppearance = %Appearance

var _state_factory := AmountEditStateFactory.new()
var _current_state: AmountEditState = null

var _amount_tracker: AmountTracker = null

signal amount_changed(amount: int)

func _ready() -> void:
	_refresh()

	if Engine.is_editor_hint():
		return

	switch_state(AmountEdit.State.IDLE)

func switch_state(state: State, state_data := AmountEditStateData.new()) -> void:
	if _current_state != null:
		_current_state.queue_free()

	_current_state = _state_factory.get_fresh_state(state)

	_current_state.setup(
		self,
		state_data,
		appearance,
		_amount_tracker)

	_current_state.state_transition_requested.connect(switch_state)
	_current_state.name = "AmountEditStateMachine: %s" % str(state)

	call_deferred("add_child", _current_state)

func _refresh() -> void:
	_amount_tracker = AmountTracker.new(AMOUNT_MINIMUM, amount_maximum)

	if appearance:
		var pad_count := len(str(amount_maximum))
		appearance.set_amount(0, pad_count)

func emit_amount_changed(amount: float) -> void:
	amount_changed.emit(amount)

func enable() -> void:
	if _current_state:
		_current_state.enable()

func disable() -> void:
	if _current_state:
		_current_state.disable()

func is_enabled() -> bool:
	return _current_state and _current_state.is_enabled()

func set_amount(amount: int) -> void:
	if _current_state:
		_current_state.set_amount(amount)

func get_current_value() -> int:
	return _amount_tracker.current()
