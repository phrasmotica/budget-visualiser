class_name CategoryCellStateEditing
extends CategoryCellState

func _enter_tree() -> void:
	print("%s is now editing" % _category_cell.name)
