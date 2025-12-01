class_name CategoryCell
extends PanelContainer

enum State { IDLE, HIGHLIGHTED, DIMMED, EDITING }

@onready
var appearance: CategoryCellAppearance = %Appearance

var _state_factory := CategoryCellStateFactory.new()
var _current_state: CategoryCellState = null

func _ready() -> void:
	switch_state(CategoryCell.State.IDLE)

func switch_state(state: State, state_data := CategoryCellStateData.new()) -> void:
	if _current_state != null:
		_current_state.queue_free()

	_current_state = _state_factory.get_fresh_state(state)

	_current_state.setup(
		self,
		state_data,
		appearance)

	_current_state.state_transition_requested.connect(switch_state)
	_current_state.name = "CategoryCellStateMachine: %s" % str(state)

	call_deferred("add_child", _current_state)

func dim() -> void:
	if _current_state:
		_current_state.dim()

func undim() -> void:
	if _current_state:
		_current_state.undim()

func highlight() -> void:
	if _current_state:
		_current_state.highlight()

func unhighlight() -> void:
	if _current_state:
		_current_state.unhighlight()

func inject_amount(amount: float) -> void:
	if _current_state:
		_current_state.inject_amount(amount)

func is_highlighted() -> bool:
	return _current_state and _current_state.is_highlighted()
