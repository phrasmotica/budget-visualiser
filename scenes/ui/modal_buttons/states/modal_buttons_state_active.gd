class_name ModalButtonsStateActive
extends ModalButtonsState

func _enter_tree() -> void:
	Logger.debug("%s is now active" % _modal_buttons.name)

	_button_manager.resume()

	SignalHelper.persist(
		_button_manager.cancelled,
		_modal_buttons.emit_cancelled
	)

	SignalHelper.persist(
		_button_manager.confirmed,
		_modal_buttons.emit_confirmed
	)

func _process(_delta: float) -> void:
	if Input.is_action_just_released("ui_right"):
		_button_manager.next()

	if Input.is_action_just_released("ui_left"):
		_button_manager.previous()

func deactivate() -> void:
	transition_state(ModalButtons.State.IDLE)
