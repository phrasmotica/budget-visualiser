@tool
class_name ButtonPanel
extends PanelContainer

enum State { IDLE, HIGHLIGHTED }

@export
var text := "":
	set(value):
		text = value

		_refresh()

@onready
var label: Label = %Label

var _state_factory := ButtonPanelStateFactory.new()
var _current_state: ButtonPanelState = null

signal pressed

func _ready() -> void:
	_refresh()

	if Engine.is_editor_hint():
		return

	switch_state(ButtonPanel.State.IDLE)

func switch_state(state: State, state_data := ButtonPanelStateData.new()) -> void:
	if _current_state != null:
		_current_state.queue_free()

	_current_state = _state_factory.get_fresh_state(state)

	_current_state.setup(
		self,
		state_data)

	_current_state.state_transition_requested.connect(switch_state)
	_current_state.name = "ButtonPanelStateMachine: %s" % str(state)

	call_deferred("add_child", _current_state)

func _refresh() -> void:
	if label:
		label.text = text

func emit_pressed() -> void:
	pressed.emit()

func highlight() -> void:
	if _current_state:
		_current_state.highlight()

func unhighlight() -> void:
	if _current_state:
		_current_state.unhighlight()
