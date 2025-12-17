class_name MonthGridStateHighlighted
extends MonthGridState

func _enter_tree() -> void:
	print("%s is now highlighted" % _month_grid.name)

	_month_grid.theme_type_variation = "HighlightedMonthGridContainer"

	_highlight_current_cell()

	SignalHelper.persist(
		GridInput.move_down,
		_on_move_down
	)

	SignalHelper.persist(
		GridInput.move_up,
		_on_move_up
	)

func _on_move_down() -> void:
	var new_cell := _cell_manager.highlight(_index_tracker.next())
	MonthGridEvents.emit_cell_highlighted(new_cell, false)

func _on_move_up() -> void:
	var new_cell := _cell_manager.highlight(_index_tracker.previous())
	MonthGridEvents.emit_cell_highlighted(new_cell, true)

func _highlight_current_cell() -> void:
	if _cell_manager.count() > 0:
		_cell_manager.highlight(_index_tracker.current())

func highlight_cell() -> void:
	_highlight_current_cell()

func unhighlight() -> void:
	transition_state(MonthGrid.State.IDLE)

func inject_amount(amount: float) -> void:
	_cell_manager.inject_amount(amount)

func is_highlighted() -> bool:
	return true
