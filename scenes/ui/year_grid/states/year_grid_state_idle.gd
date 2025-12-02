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
	var left := int(grid.position.x)
	var right := left + int(grid.size.x)

	if _year_grid.scroll_horizontal <= left and _year_grid.scroll_horizontal + _year_grid.size.x >= right:
		return

	# TODO: improve this scrolling behaviour further
	var scroll_amount_left := left - _year_grid.scroll_horizontal
	var scroll_amount_right := right - _year_grid.scroll_horizontal

	if scroll_amount_left < scroll_amount_right:
		_year_grid.scroll_horizontal = left
	else:
		_year_grid.scroll_horizontal = right
