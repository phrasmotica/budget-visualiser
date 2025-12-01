class_name YearGridStateIdle
extends YearGridState

func _enter_tree() -> void:
	print("%s is now idle" % _year_grid.name)

	_year_grid.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_AUTO

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

	SignalHelper.persist(
		_month_grid_manager.highlighted_grid_changed,
		_on_highlighted_grid_changed
	)

func disable() -> void:
	transition_state(YearGrid.State.DISABLED)

func inject_amount(amount: float) -> void:
	_month_grid_manager.inject_amount(amount)

func update_budget(data: BudgetData) -> void:
	_month_grid_manager.inject_budget(data)

func _on_move_right() -> void:
	_month_grid_manager.highlight(_index_tracker.next())

func _on_move_left() -> void:
	_month_grid_manager.highlight(_index_tracker.previous())

func _on_highlighted_grid_changed(grid: MonthGrid) -> void:
	# TODO: don't change the scroll if the grid is already fully on screen
	_year_grid.scroll_horizontal = int(grid.position.x)
