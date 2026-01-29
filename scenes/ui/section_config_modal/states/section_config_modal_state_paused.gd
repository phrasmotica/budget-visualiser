class_name SectionConfigModalStatePaused
extends SectionConfigModalState

func _enter_tree() -> void:
	Logger.debug("%s is now paused" % _section_config_modal.name)

	SignalHelper.persist(_category_list.enabled, _to_active)

func _to_active() -> void:
	transition_state(SectionConfigModal.State.SHOWN)
