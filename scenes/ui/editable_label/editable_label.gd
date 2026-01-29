@tool
class_name EditableLabel
extends PanelContainer

enum State { IDLE, HIGHLIGHTED, EDITING }

@export
var is_editing := false:
	set(value):
		is_editing = value

		_refresh()

@export
var text := "":
	set(value):
		text = value

		emit_text_changed(text)

		_refresh()

@onready
var appearance: EditableLabelAppearance = %Appearance

@onready
var line_edit: LineEdit = %LineEdit

var _state_factory := EditableLabelStateFactory.new()
var _current_state: EditableLabelState = null

signal text_changed(text: String)
signal activated
signal deactivated

func _ready() -> void:
	_refresh()

	if Engine.is_editor_hint():
		return

	switch_state(State.IDLE)

func switch_state(state: State, state_data := EditableLabelStateData.new()) -> void:
	if _current_state != null:
		_current_state.queue_free()

	_current_state = _state_factory.get_fresh_state(state)

	_current_state.setup(
		self,
		state_data,
		appearance,
		line_edit)

	_current_state.state_transition_requested.connect(switch_state)
	_current_state.name = "EditableLabelStateMachine: %s" % str(state)

	call_deferred("add_child", _current_state)

func _refresh() -> void:
	if appearance:
		appearance.set_label_text(text)
		appearance.copy_label_text_to_line_edit()

		if is_editing:
			appearance.for_editing()
		else:
			appearance.for_highlighted()

func emit_activated() -> void:
	activated.emit()

func emit_deactivated() -> void:
	deactivated.emit()

func emit_text_changed(new_text: String) -> void:
	text_changed.emit(new_text)

func highlight() -> void:
	if _current_state:
		_current_state.highlight()

func unhighlight() -> void:
	if _current_state:
		_current_state.unhighlight()
