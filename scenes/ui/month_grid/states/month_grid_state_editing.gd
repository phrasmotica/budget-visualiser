class_name MonthGridStateEditing
extends MonthGridState

func _enter_tree() -> void:
	Logger.debug("%s is now editing" % _month_grid.name)
