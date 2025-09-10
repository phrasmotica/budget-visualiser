class_name AmountEdit
extends PanelContainer

const AMOUNT_MINIMUM := 0
const AMOUNT_MAXIMUM := 99

enum State { IDLE, HIGHLIGHTED }

@onready
var appearance: AmountEditAppearance = %Appearance

var _state_factory := AmountEditStateFactory.new()
var _current_state: AmountEditState = null

var _amount_tracker: AmountTracker = null

func _ready() -> void:
	_amount_tracker = AmountTracker.new(AMOUNT_MINIMUM, AMOUNT_MAXIMUM)

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

func enable() -> void:
	if _current_state:
		_current_state.enable()

func disable() -> void:
	if _current_state:
		_current_state.disable()

func is_enabled() -> bool:
	return _current_state and _current_state.is_enabled()

func get_current_value() -> int:
	return _amount_tracker.current()
