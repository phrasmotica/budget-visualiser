class_name ButtonPanelStateHighlighted
extends ButtonPanelState

func _enter_tree() -> void:
	print("%s is now highlighted" % _button_panel.name)

	_button_panel.theme_type_variation = "HighlightedButtonPanel"

func _process(_delta: float) -> void:
	if Input.is_action_just_released("ui_accept"):
		_button_panel.emit_pressed()

func unhighlight() -> void:
	transition_state(ButtonPanel.State.IDLE)
