class_name SectionConfigModalStateHidden
extends SectionConfigModalState

func _enter_tree() -> void:
	Logger.debug("%s is now hidden" % _section_config_modal.name)

	_section_config_modal.hide()
	_modal_buttons.reset_highlight()
