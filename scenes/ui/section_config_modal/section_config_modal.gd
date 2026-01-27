@tool
class_name SectionConfigModal
extends PanelContainer

enum State { HIDDEN, SHOWN }

@export
var section: BudgetSection:
	set(value):
		section = value

		_refresh()

@onready
var appearance: SectionConfigModalAppearance = %Appearance

@onready
var modal_buttons: ModalButtons = %ModalButtons

var _state_factory := SectionConfigModalStateFactory.new()
var _current_state: SectionConfigModalState = null

func _ready() -> void:
	_refresh()

	if Engine.is_editor_hint():
		return

	switch_state(State.HIDDEN)

func switch_state(state: State, state_data := SectionConfigModalStateData.new()) -> void:
	if _current_state != null:
		_current_state.queue_free()

	_current_state = _state_factory.get_fresh_state(state)

	_current_state.setup(
		self,
		state_data,
		appearance,
		modal_buttons)

	_current_state.state_transition_requested.connect(switch_state)
	_current_state.name = "SectionConfigModalStateMachine: %s" % str(state)

	call_deferred("add_child", _current_state)

func _refresh() -> void:
	if appearance:
		appearance.set_section(section)
