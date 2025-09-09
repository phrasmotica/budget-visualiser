class_name AmountEdit
extends PanelContainer

enum State { IDLE, HIGHLIGHTED }

@onready
var appearance: AmountEditAppearance = %Appearance

var _state_factory := AmountEditStateFactory.new()
var _current_state: AmountEditState = null

func _ready() -> void:
	switch_state(AmountEdit.State.IDLE)

func switch_state(state: State, state_data := AmountEditStateData.new()) -> void:
	if _current_state != null:
		_current_state.queue_free()

	_current_state = _state_factory.get_fresh_state(state)

	_current_state.setup(
		self,
		state_data,
		appearance)

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
