@tool
class_name EditableLabelManager
extends Node

@export
var labels: Array[EditableLabel] = []:
	set(value):
		labels = value

		for l in labels:
			SignalHelper.chain(l.activated, label_activated)
			SignalHelper.chain(l.deactivated, label_deactivated)

signal label_activated
signal label_deactivated

func _ready() -> void:
	if Engine.is_editor_hint():
		return

func update_highlight(index: int) -> void:
	for i in labels.size():
		var label := labels[i]

		if index == i:
			label.highlight()
		else:
			label.unhighlight()

func get_label_count() -> int:
	return labels.size()
