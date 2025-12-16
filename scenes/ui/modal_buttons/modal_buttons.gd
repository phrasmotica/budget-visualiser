@tool
class_name ModalButtons
extends VBoxContainer

enum State { IDLE, ACTIVE }

@onready
var finished_button: ButtonPanel = %FinishedButton

var _state_factory := ModalButtonsStateFactory.new()
var _current_state: ModalButtonsState = null

signal finished

func _ready() -> void:
	_refresh()

	if Engine.is_editor_hint():
		return

	switch_state(State.IDLE)

func switch_state(state: State, state_data := ModalButtonsStateData.new()) -> void:
	if _current_state != null:
		_current_state.queue_free()

	_current_state = _state_factory.get_fresh_state(state)

	_current_state.setup(
		self,
		state_data,
		finished_button)

	_current_state.state_transition_requested.connect(switch_state)
	_current_state.name = "ModalButtonsStateMachine: %s" % str(state)

	call_deferred("add_child", _current_state)

func _refresh() -> void:
	pass

func emit_finished() -> void:
	finished.emit()

func activate() -> void:
	if _current_state:
		_current_state.activate()

func deactivate() -> void:
	if _current_state:
		_current_state.deactivate()
