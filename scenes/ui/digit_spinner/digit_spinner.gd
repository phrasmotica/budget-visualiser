@tool
class_name DigitSpinner
extends PanelContainer

enum State { IDLE, ACTIVE }

@export
var amount := 0:
	set(value):
		amount = clampi(value, 0, 9)

		_refresh()

@onready
var appearance: DigitSpinnerAppearance = %Appearance

var _state_factory := DigitSpinnerStateFactory.new()
var _current_state: DigitSpinnerState = null

signal amount_changed

func _ready() -> void:
	if Engine.is_editor_hint():
		return

	switch_state(State.IDLE)

func switch_state(state: State, state_data := DigitSpinnerStateData.new()) -> void:
	if _current_state != null:
		_current_state.queue_free()

	_current_state = _state_factory.get_fresh_state(state)

	_current_state.setup(
		self,
		state_data,
		appearance)

	_current_state.state_transition_requested.connect(switch_state)
	_current_state.name = "DigitSpinnerStateMachine: %s" % str(state)

	call_deferred("add_child", _current_state)

func _refresh() -> void:
	if appearance:
		appearance.set_amount(amount)

func emit_amount_changed() -> void:
	amount_changed.emit()

func highlight() -> void:
	if _current_state:
		_current_state.highlight()

func unhighlight() -> void:
	if _current_state:
		_current_state.unhighlight()
