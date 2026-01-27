class_name SectionConfigModalStateShown
extends SectionConfigModalState

const MAPPING_CONTEXT: GUIDEMappingContext = preload(
	"res://resources/input/ctx_modal_buttons.tres")

func _enter_tree() -> void:
	Logger.debug("%s is now shown" % _section_config_modal.name)

	GUIDE.enable_mapping_context(MAPPING_CONTEXT)

	_section_config_modal.show()
	_modal_buttons.activate()

	SignalHelper.persist(
		_modal_buttons.cancelled,
		_cancel
	)

	SignalHelper.persist(
		_modal_buttons.confirmed,
		_finish
	)

	SignalHelper.persist(ConfirmCancelInput.cancel, _cancel)

func _exit_tree() -> void:
	GUIDE.disable_mapping_context(MAPPING_CONTEXT)

func _cancel() -> void:
	Logger.info("Cancelled section config")

	_to_hidden()

func _finish() -> void:
	Logger.info("Finished section config")

	_to_hidden()

func _to_hidden() -> void:
	transition_state(SectionConfigModal.State.HIDDEN)
