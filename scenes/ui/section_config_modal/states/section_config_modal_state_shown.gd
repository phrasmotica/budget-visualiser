class_name SectionConfigModalStateShown
extends SectionConfigModalState

func _enter_tree() -> void:
	Logger.debug("%s is now shown" % _section_config_modal.name)

	_section_config_modal.show()
	_category_list.activate()

	SignalHelper.persist(
		_modal_buttons.cancelled,
		_cancel
	)

	SignalHelper.persist(
		_modal_buttons.confirmed,
		_finish
	)

	SignalHelper.persist(ConfirmCancelInput.cancel, _cancel)

func _cancel() -> void:
	Logger.info("Cancelled section config")

	SectionConfigEvents.emit_cancelled()

	_to_hidden()

func _finish() -> void:
	Logger.info("Finished section config")

	SectionConfigEvents.emit_cancelled()

	_to_hidden()

func _to_hidden() -> void:
	transition_state(SectionConfigModal.State.HIDDEN)

func disable() -> void:
	_to_hidden()
