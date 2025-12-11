class_name YearGridStateDisabled
extends YearGridState

func _enter_tree() -> void:
	print("%s is now disabled" % _year_grid.name)

	_month_grid_manager.pause()

func enable() -> void:
	transition_state(YearGrid.State.IDLE)
