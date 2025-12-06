@tool
class_name MonthGrid
extends PanelContainer

enum State { DISABLED, IDLE, HIGHLIGHTED, EDITING }

@export
var month: BudgetMonth:
	set(value):
		month = value

		_refresh()

@onready
var appearance: MonthGridAppearance = %Appearance

@onready
var cell_manager: CellManager = %CellManager

var _state_factory := MonthGridStateFactory.new()
var _current_state: MonthGridState = null

var _index_tracker: IndexTracker = null

func _ready() -> void:
	_refresh()

	if Engine.is_editor_hint():
		return

	_index_tracker = IndexTracker.new(cell_manager.count() - 1)

	switch_state(MonthGrid.State.DISABLED)

func switch_state(state: State, state_data := MonthGridStateData.new()) -> void:
	if _current_state != null:
		_current_state.queue_free()

	_current_state = _state_factory.get_fresh_state(state)

	_current_state.setup(
		self,
		state_data,
		cell_manager,
		_index_tracker)

	_current_state.state_transition_requested.connect(switch_state)
	_current_state.name = "MonthGridStateMachine: %s" % str(state)

	call_deferred("add_child", _current_state)

func _refresh() -> void:
	if appearance:
		appearance.set_month_name(month.name if month else "")

func enable() -> void:
	if _current_state:
		_current_state.enable()

func disable() -> void:
	if _current_state:
		_current_state.disable()

func highlight() -> void:
	if _current_state:
		_current_state.highlight()

func unhighlight() -> void:
	if _current_state:
		_current_state.unhighlight()

func inject_amount(amount: float) -> void:
	if _current_state:
		_current_state.inject_amount(amount)

func inject_budget(data: BudgetData) -> void:
	if _current_state:
		_current_state.inject_budget(data)

func is_highlighted() -> bool:
	return _current_state and _current_state.is_highlighted()

func get_highlighted_category() -> BudgetCategory:
	return cell_manager.get_highlighted_category()
