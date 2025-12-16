class_name ModalButtonsStateActive
extends ModalButtonsState

func _enter_tree() -> void:
	print("%s is now active" % _modal_buttons.name)

	_finished_button.highlight()

	SignalHelper.persist(
		_finished_button.pressed,
		_modal_buttons.emit_finished
	)

func deactivate() -> void:
	transition_state(ModalButtons.State.IDLE)
