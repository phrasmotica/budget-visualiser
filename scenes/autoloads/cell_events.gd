extends Node

# TODO: to be replaced by a list of cell groups...
var _cells: Array[CategoryCell] = []

func _ready() -> void:
	SignalHelper.once_next_frame(_on_initialised)

func _on_initialised() -> void:
	# TODO: assume all cell groups have reported in. Highlight the first one,
	# which should then highlight the first cell in the group
	if _cells.size() > 0:
		_cells[0].highlight()

func emit_cell_group_created(cells: Array[CategoryCell]) -> void:
	_cells.append_array(cells)
