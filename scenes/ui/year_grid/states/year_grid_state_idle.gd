class_name YearGridStateIdle
extends YearGridState

var _highlight_index := -1

func _enter_tree() -> void:
	print("%s is now idle" % _year_grid.name)

	if _month_grid_manager.count() > 0:
		_highlight_index = 0

		_month_grid_manager.highlight(_highlight_index)

	SignalHelper.persist(
		GridInput.move_right,
		_on_move_right
	)

	SignalHelper.persist(
		GridInput.move_left,
		_on_move_left
	)

func _on_move_right() -> void:
	print("%s _on_move_right" % _year_grid.name)

	_highlight_index = mini(_highlight_index + 1, _month_grid_manager.count() - 1)

	_month_grid_manager.highlight(_highlight_index)

func _on_move_left() -> void:
	print("%s _on_move_left" % _year_grid.name)

	_highlight_index = maxi(0, _highlight_index - 1)

	_month_grid_manager.highlight(_highlight_index)
