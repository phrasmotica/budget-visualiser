class_name ButtonPanelStateIdle
extends ButtonPanelState

func _enter_tree() -> void:
	print("%s is now idle" % _button_panel.name)

	_button_panel.theme_type_variation = "IdleButtonPanel"

func highlight() -> void:
	transition_state(ButtonPanel.State.HIGHLIGHTED)
