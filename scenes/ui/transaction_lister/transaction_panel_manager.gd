class_name TransactionPanelManager
extends Node

@export
var select_panels: Array[TransactionSelectPanel] = []

var _highlighted_index := -1

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
	var new_hidden := not select_panels[_highlighted_index].transaction.hidden

	print("Transaction %d hidden: %s" % [_highlighted_index, new_hidden])

	select_panels[_highlighted_index].transaction.hidden = new_hidden

	return new_hidden

func count() -> int:
	return select_panels.size()
