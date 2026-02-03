@tool
class_name EditableLabelManager
extends Node

@export
var labels: Array[EditableLabel] = []:
	set(value):
		labels = value

		for l in labels:
			SignalHelper.persist(l.activated, _on_label_activated.bind(l))
			SignalHelper.persist(l.deactivated, _on_label_deactivated.bind(l))

		_refresh()

@export
var label_parent: Container

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

func _on_label_activated(label: EditableLabel) -> void:
	for l in labels:
		if l != label:
			l.disable()

	label_activated.emit()

func _on_label_deactivated(label: EditableLabel) -> void:
	for l in labels:
		if l != label:
			l.enable()

	label_deactivated.emit()

func get_label_count() -> int:
	return labels.size()

func set_text_list(text_list: Array[String]) -> void:
	_ensure_labels(text_list.size())

	for i in labels.size():
		labels[i].text = text_list[i]

func _ensure_labels(count: int) -> void:
	var label_count := labels.size()

	labels.clear()

	for i in count:
		var label: EditableLabel

		if i >= label_count:
			label = EditableLabelFactory.create_label(i)

			label_parent.add_child(label)
			label.owner = label_parent
		else:
			label = label_parent.get_child(i) as EditableLabel

		labels.append(label)

	while label_parent.get_child_count() > count:
		var child_to_remove := label_parent.get_child(-1)
		label_parent.remove_child(child_to_remove)
		child_to_remove.queue_free()

func get_text_list() -> Array[String]:
	var text_list: Array[String] = []

	for l in labels:
		text_list.append(l.text)

	return text_list
