class_name TransactionPanelManager
extends Node

@export
var select_panels: Array[TransactionSelectPanel] = []

var _highlighted_index := -1
var _inclusion_mask: Array[bool] = []

func _ready() -> void:
	for s in select_panels:
		_inclusion_mask.append(true)

func highlight(index: int) -> TransactionSelectPanel:
	if index < 0 or index > select_panels.size() - 1:
		print("Cannot highlight TransactionSelectPanel at invalid index %d!" % index)
		return null

	_highlighted_index = index

	for i in select_panels.size():
		if i == _highlighted_index:
			select_panels[i].highlight()
		else:
			select_panels[i].unhighlight()

	return select_panels[_highlighted_index]

func unhighlight() -> void:
	select_panels[_highlighted_index].unhighlight()

func toggle_current() -> bool:
	var new_inclusion := not _inclusion_mask[_highlighted_index]

	print("Transaction %d included: %s" % [_highlighted_index, new_inclusion])

	_inclusion_mask[_highlighted_index] = new_inclusion

	if new_inclusion:
		select_panels[_highlighted_index].undim()
	else:
		select_panels[_highlighted_index].dim()

	return new_inclusion

func count() -> int:
	return select_panels.size()
