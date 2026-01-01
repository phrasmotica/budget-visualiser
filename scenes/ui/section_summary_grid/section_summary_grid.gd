@tool
class_name SectionSummaryGrid
extends MarginContainer

enum State { IDLE, DISABLED }

@export
var section: BudgetSection:
	set(value):
		section = value

		_refresh()

@onready
var section_cell_manager: SectionCellManager = %SectionCellManager

@onready
var name_label: Label = %NameLabel

var _state_factory := SectionSummaryGridStateFactory.new()
var _current_state: SectionSummaryGridState = null

func _ready() -> void:
	_refresh()

	if Engine.is_editor_hint():
		return

	switch_state(State.IDLE)

func switch_state(state: State, state_data := SectionSummaryGridStateData.new()) -> void:
	if _current_state != null:
		_current_state.queue_free()

	_current_state = _state_factory.get_fresh_state(state)

	_current_state.setup(
		self,
		state_data,
		section_cell_manager)

	_current_state.state_transition_requested.connect(switch_state)
	_current_state.name = "SectionSummaryGridStateMachine: %s" % str(state)

	call_deferred("add_child", _current_state)

func _refresh() -> void:
	if name_label:
		name_label.text = ("%s total" % section.name) if section else "???"

	if _current_state:
		_current_state.refresh_appearance()
