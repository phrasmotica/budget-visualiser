@tool
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

func count() -> int:
	return select_panels.size()
