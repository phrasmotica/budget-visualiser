class_name ButtonManager
extends Node

@export
var cancel: ButtonPanel

@export
var confirm: ButtonPanel

var _index_tracker := IndexTracker.new(
	_get_buttons().size() - 1,
	"ButtonManagerIndexTracker"
)

signal cancelled
signal confirmed

func _ready() -> void:
	SignalHelper.chain(cancel.pressed, cancelled)
	SignalHelper.chain(confirm.pressed, confirmed)

func next() -> void:
	_refresh_highlight(_index_tracker.next())

func previous() -> void:
	_refresh_highlight(_index_tracker.previous())

func pause() -> void:
	_get_buttons()[_index_tracker.current()].unhighlight()

func resume() -> void:
	_get_buttons()[_index_tracker.current()].highlight()

func _refresh_highlight(index: int) -> void:
	var buttons := _get_buttons()

	for i in buttons.size():
		if i == index:
			buttons[i].highlight()
		else:
			buttons[i].unhighlight()

func _get_buttons() -> Array[ButtonPanel]:
	return [cancel, confirm]
