class_name SectionConfigModalStateShown
extends SectionConfigModalState

func _enter_tree() -> void:
	Logger.debug("%s is now shown" % _section_config_modal.name)
