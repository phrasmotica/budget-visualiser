class_name ModalButtonsStateIdle
extends ModalButtonsState

func _enter_tree() -> void:
	print("%s is now idle" % _modal_buttons.name)

	_finished_button.unhighlight()

func activate() -> void:
	transition_state(ModalButtons.State.ACTIVE)
