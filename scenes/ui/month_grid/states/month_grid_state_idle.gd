class_name MonthGridStateIdle
extends MonthGridState

func _enter_tree() -> void:
	print("%s is now idle" % _month_grid.name)

	_month_grid.theme_type_variation = "IdleMonthGridContainer"

	for c in _cell_manager.cells:
		# TODO: keep the appropriate cell highlighted, but in a much dimmer
		# shade than the highlighted cell in the highlighted month...
		c.unhighlight()

func highlight() -> void:
	transition_state(MonthGrid.State.HIGHLIGHTED)
