class_name SectionConfigModalStateShown
extends SectionConfigModalState

const MAPPING_CONTEXT: GUIDEMappingContext = preload(
	"res://resources/input/ctx_section_config_modal_active.tres")

func _enter_tree() -> void:
	Logger.debug("%s is now shown" % _section_config_modal.name)

	GUIDE.enable_mapping_context(MAPPING_CONTEXT)

	_section_config_modal.show()

	_category_list.activate()

	SignalHelper.persist(ConfirmCancelInput.cancel, _cancel)

	SignalHelper.persist(NavigationInput.next_section, _to_finishing)

func _exit_tree() -> void:
	GUIDE.disable_mapping_context(MAPPING_CONTEXT)

func _cancel() -> void:
	Logger.info("Cancelled section config")

	SectionConfigEvents.emit_cancelled()

	_to_hidden()

func _to_finishing() -> void:
	_category_list.deactivate()

	transition_state(SectionConfigModal.State.FINISHING)

func _to_hidden() -> void:
	_category_list.deactivate()

	transition_state(SectionConfigModal.State.HIDDEN)

func disable() -> void:
	_to_hidden()
