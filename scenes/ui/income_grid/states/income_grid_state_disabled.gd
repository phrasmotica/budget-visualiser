class_name IncomeGridStateDisabled
extends IncomeGridState

func _enter_tree() -> void:
	Logger.debug("%s is now disabled" % _income_grid.name)
