class_name MonthGridStateHighlighted
extends MonthGridState

func _enter_tree() -> void:
	print("%s is now highlighted" % _month_grid.name)
