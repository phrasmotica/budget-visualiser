class_name MonthGridStateHighlighted
extends MonthGridState

func _enter_tree() -> void:
	print("%s is now highlighted" % _month_grid.name)

	_month_grid.theme_type_variation = "HighlightedMonthGridContainer"

	if _cell_manager.count() > 0:
		_cell_manager.highlight(_index_tracker.current())

	SignalHelper.persist(
		GridInput.move_down,
		_on_move_down
	)

	SignalHelper.persist(
		GridInput.move_up,
		_on_move_up
	)

func _on_move_down() -> void:
	_cell_manager.highlight(_index_tracker.next())

func _on_move_up() -> void:
	_cell_manager.highlight(_index_tracker.previous())

func unhighlight() -> void:
	transition_state(MonthGrid.State.IDLE)
