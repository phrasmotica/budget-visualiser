class_name MonthGridStateIdle
extends MonthGridState

func _enter_tree() -> void:
	print("%s is now idle" % _month_grid.name)
