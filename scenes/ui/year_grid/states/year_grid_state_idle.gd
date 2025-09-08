class_name YearGridStateIdle
extends YearGridState

func _enter_tree() -> void:
	print("%s is now idle" % _year_grid.name)

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

func _on_move_right() -> void:
	_month_grid_manager.highlight(_index_tracker.next())

func _on_move_left() -> void:
	_month_grid_manager.highlight(_index_tracker.previous())
