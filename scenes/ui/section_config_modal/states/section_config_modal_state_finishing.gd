class_name SectionConfigModalStateFinishing
extends SectionConfigModalState

const MAPPING_CONTEXT: GUIDEMappingContext = preload(
	"res://resources/input/ctx_modal_buttons.tres")

func _enter_tree() -> void:
	Logger.debug("%s is now finishing" % _section_config_modal.name)

	GUIDE.enable_mapping_context(MAPPING_CONTEXT)

	_appearance.for_finishing()

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

	SignalHelper.persist(NavigationInput.next_section, _to_active)

func _exit_tree() -> void:
	GUIDE.disable_mapping_context(MAPPING_CONTEXT)

func _cancel() -> void:
	Logger.info("Cancelled section config")

	SectionConfigEvents.emit_cancelled()

	_to_hidden()

func _finish() -> void:
	Logger.info("Finished section config")

	BudgetProvider.apply_section_changes(
		_section_config_modal.section,
		_category_list.get_text_list())

	SectionConfigEvents.emit_cancelled()

	_to_hidden()

func _to_active() -> void:
	_modal_buttons.deactivate()

	transition_state(SectionConfigModal.State.SHOWN)

func _to_hidden() -> void:
	_modal_buttons.reset_highlight()
	_modal_buttons.deactivate()

	transition_state(SectionConfigModal.State.HIDDEN)
