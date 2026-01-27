class_name EditableLabelStateIdle
extends EditableLabelState

const MAPPING_CONTEXT: GUIDEMappingContext = preload(
	"res://resources/input/ctx_editable_label_idle.tres")

func _enter_tree() -> void:
	Logger.debug("%s is now idle" % _editable_label.name)

	GUIDE.enable_mapping_context(MAPPING_CONTEXT)

	_appearance.for_idle()

	SignalHelper.persist(
		ConfirmCancelInput.confirm,
		_to_editing)

func _exit_tree() -> void:
	GUIDE.disable_mapping_context(MAPPING_CONTEXT)

func _to_editing() -> void:
	_appearance.copy_label_text_to_line_edit()

	transition_state(EditableLabel.State.EDITING)
