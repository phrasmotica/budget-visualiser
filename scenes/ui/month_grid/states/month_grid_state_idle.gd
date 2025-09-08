class_name MonthGridStateIdle
extends MonthGridState

func _enter_tree() -> void:
	print("%s is now idle" % _month_grid.name)

	for c in _cell_manager.cells:
		c.unhighlight()

func highlight() -> void:
	transition_state(MonthGrid.State.HIGHLIGHTED)
