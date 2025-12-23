class_name IncomeGridStateIdle
extends IncomeGridState

func _enter_tree() -> void:
	Logger.debug("%s is now idle" % _income_grid.name)
