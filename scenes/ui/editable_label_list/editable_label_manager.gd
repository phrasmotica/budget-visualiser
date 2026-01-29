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

		_refresh()

var _index_tracker: IndexTracker = null

signal label_activated
signal label_deactivated

func _ready() -> void:
	if Engine.is_editor_hint():
		return

	_refresh()

func _refresh() -> void:
	_index_tracker = IndexTracker.new(
		labels.size() - 1,
		"EditableLabelManagerIndexTracker")

func highlight_current() -> void:
	_update_highlight(_index_tracker.current())

func highlight_next() -> void:
	_update_highlight(_index_tracker.next())

func highlight_previous() -> void:
	_update_highlight(_index_tracker.previous())

func _update_highlight(index: int) -> void:
	for i in labels.size():
		var label := labels[i]

		if index == i:
			label.highlight()
		else:
			label.unhighlight()

func get_label_count() -> int:
	return labels.size()
