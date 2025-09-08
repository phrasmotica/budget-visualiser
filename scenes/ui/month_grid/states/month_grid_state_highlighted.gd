class_name MonthGridStateHighlighted
extends MonthGridState

var _highlight_index := -1

func _enter_tree() -> void:
	print("%s is now highlighted" % _month_grid.name)

	if _cell_manager.count() > 0:
		# TODO: allow a highlight index to be passed in
		_highlight_index = 0

		_cell_manager.highlight(_highlight_index)

	SignalHelper.persist(
		GridInput.move_down,
		_on_move_down
	)

	SignalHelper.persist(
		GridInput.move_up,
		_on_move_up
	)

func _on_move_down() -> void:
	print("%s _on_move_down" % _month_grid.name)

	_highlight_index = mini(_highlight_index + 1, _cell_manager.count() - 1)

	_cell_manager.highlight(_highlight_index)

func _on_move_up() -> void:
	print("%s _on_move_up" % _month_grid.name)

	_highlight_index = maxi(0, _highlight_index - 1)

	_cell_manager.highlight(_highlight_index)

func unhighlight() -> void:
	transition_state(MonthGrid.State.IDLE)
