class_name AmountEntryModal
extends PanelContainer

enum State { HIDDEN, SHOWN }

@onready
var appearance: AmountEntryModalAppearance = %Appearance

@onready
var totaller: AmountTotaller = %Totaller

var _state_factory := AmountEntryModalStateFactory.new()
var _current_state: AmountEntryModalState = null

func _ready() -> void:
	switch_state(AmountEntryModal.State.SHOWN)

func switch_state(state: State, state_data := AmountEntryModalStateData.new()) -> void:
	if _current_state != null:
		_current_state.queue_free()

	_current_state = _state_factory.get_fresh_state(state)

	_current_state.setup(
		self,
		state_data,
		appearance,
		totaller)

	_current_state.state_transition_requested.connect(switch_state)
	_current_state.name = "AmountEntryModalStateMachine: %s" % str(state)

	call_deferred("add_child", _current_state)

func enable() -> void:
	if _current_state:
		_current_state.enable()

func disable() -> void:
	if _current_state:
		_current_state.disable()
