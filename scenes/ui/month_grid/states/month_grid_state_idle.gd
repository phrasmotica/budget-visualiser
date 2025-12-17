class_name MonthGridStateIdle
extends MonthGridState

func _enter_tree() -> void:
	print("%s is now idle" % _month_grid.name)

	_month_grid.theme_type_variation = "IdleMonthGridContainer"

	_dim_current_cell()

	SignalHelper.persist(
		GridInput.move_down,
		_on_move_down
	)

	SignalHelper.persist(
		GridInput.move_up,
		_on_move_up
	)

func _on_move_down() -> void:
	_cell_manager.dim(_index_tracker.next())

func _on_move_up() -> void:
	_cell_manager.dim(_index_tracker.previous())

func _dim_current_cell() -> void:
	if _cell_manager.count() > 0:
		_cell_manager.dim(_index_tracker.current())

func highlight_cell() -> void:
	_dim_current_cell()

func disable() -> void:
	transition_state(MonthGrid.State.DISABLED)

func highlight() -> void:
	transition_state(MonthGrid.State.HIGHLIGHTED)
