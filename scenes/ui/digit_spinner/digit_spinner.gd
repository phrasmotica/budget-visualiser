class_name DigitSpinner
extends PanelContainer

enum State { IDLE, ACTIVE }

@onready
var appearance: DigitSpinnerAppearance = %Appearance

var _state_factory := DigitSpinnerStateFactory.new()
var _current_state: DigitSpinnerState = null

var _amount_tracker := AmountTracker.new(0, 9)

signal amount_changed(amount: int)

func _ready() -> void:
	switch_state(State.IDLE)

func switch_state(state: State, state_data := DigitSpinnerStateData.new()) -> void:
	if _current_state != null:
		_current_state.queue_free()

	_current_state = _state_factory.get_fresh_state(state)

	_current_state.setup(
		self,
		state_data,
		appearance,
		_amount_tracker)

	_current_state.state_transition_requested.connect(switch_state)
	_current_state.name = "DigitSpinnerStateMachine: %s" % str(state)

	call_deferred("add_child", _current_state)

func emit_amount_changed(amount: float) -> void:
	amount_changed.emit(amount)
