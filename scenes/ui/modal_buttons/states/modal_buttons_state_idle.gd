class_name ModalButtonsStateIdle
extends ModalButtonsState

func _enter_tree() -> void:
	print("%s is now idle" % _modal_buttons.name)

	_button_manager.pause()

func activate() -> void:
	transition_state(ModalButtons.State.ACTIVE)
