class_name YearGridStateIdle
extends YearGridState

var _needs_to_scroll_left := false
var _needs_to_scroll_right := false

func _enter_tree() -> void:
	print("%s is now idle" % _year_grid.name)

	_appearance.for_idle()

	if _month_grid_manager.count() > 0:
		_month_grid_manager.highlight(_index_tracker.current())

	SignalHelper.persist(
		GridInput.move_right,
		_on_move_right
	)

	SignalHelper.persist(
		GridInput.move_left,
		_on_move_left
	)

func disable() -> void:
	transition_state(YearGrid.State.DISABLED)

func inject_amount(amount: float) -> void:
	_month_grid_manager.inject_amount(amount)

func update_budget(data: BudgetData) -> void:
	_month_grid_manager.inject_budget(data)

func _on_move_right() -> void:
	_needs_to_scroll_right = true
	var new_grid := _month_grid_manager.highlight(_index_tracker.next())
	_appearance.scroll_right_to_highlighted_grid(new_grid)

func _on_move_left() -> void:
	_needs_to_scroll_left = true
	var new_grid := _month_grid_manager.highlight(_index_tracker.previous())
	_appearance.scroll_left_to_highlighted_grid(new_grid)
