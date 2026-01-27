class_name EditableLabelStateHighlighted
extends EditableLabelState

const MAPPING_CONTEXT: GUIDEMappingContext = preload(
	"res://resources/input/ctx_editable_label_highlighted.tres")

func _enter_tree() -> void:
	Logger.debug("%s is now highlighted" % _editable_label.name)

	GUIDE.enable_mapping_context(MAPPING_CONTEXT)

	_appearance.for_highlighted()

	SignalHelper.persist(
		ConfirmCancelInput.confirm,
		_to_editing)

func _exit_tree() -> void:
	GUIDE.disable_mapping_context(MAPPING_CONTEXT)

func _to_editing() -> void:
	_appearance.copy_label_text_to_line_edit()

	transition_state(EditableLabel.State.EDITING)

func unhighlight() -> void:
	transition_state(EditableLabel.State.IDLE)
