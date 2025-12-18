class_name ButtonPanelStateHighlighted
extends ButtonPanelState

func _enter_tree() -> void:
	Logger.debug("%s is now highlighted" % _button_panel.name)

	_button_panel.theme_type_variation = "HighlightedButtonPanel"

	SignalHelper.persist(ConfirmCancelInput.confirm, _confirm)

func _confirm() -> void:
	_button_panel.emit_pressed()

func unhighlight() -> void:
	transition_state(ButtonPanel.State.IDLE)
