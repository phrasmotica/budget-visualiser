class_name CellManager
extends Node

@export
var cells: Array[CategoryCell] = []

func highlight(index: int) -> void:
	for i in cells.size():
		if i == index:
			cells[i].highlight()
		else:
			cells[i].unhighlight()

func dim(index: int) -> void:
	for i in cells.size():
		if i == index:
			cells[i].dim()

func inject_amount(amount: float) -> void:
	print("Injecting %.2f into cell manager" % amount)

	for c in cells:
		if c.is_highlighted():
			print("Injecting %.2f into cell %s" % [amount, c.name])
			c.inject_amount(amount)

func count() -> int:
	return cells.size()
