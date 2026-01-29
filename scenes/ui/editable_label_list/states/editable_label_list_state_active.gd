class_name EditableLabelListStateActive
extends EditableLabelListState

const MAPPING_CONTEXT: GUIDEMappingContext = preload(
	"res://resources/input/ctx_editable_label_list_active.tres")

func _enter_tree() -> void:
	Logger.debug("%s is now active" % _editable_label_list.name)

	GUIDE.enable_mapping_context(MAPPING_CONTEXT)

	_label_manager.highlight_current()

	SignalHelper.persist(
		GridInput.move_down,
		_on_move_down
	)

	SignalHelper.persist(
		GridInput.move_up,
		_on_move_up
	)

	SignalHelper.persist(
		_label_manager.label_activated,
		_on_label_activated
	)

func _exit_tree() -> void:
	GUIDE.disable_mapping_context(MAPPING_CONTEXT)

func _on_move_down() -> void:
	_label_manager.highlight_next()

func _on_move_up() -> void:
	_label_manager.highlight_previous()

func _on_label_activated() -> void:
	_editable_label_list.emit_disabled()

	transition_state(EditableLabelList.State.DISABLED)

func deactivate() -> void:
	transition_state(EditableLabelList.State.IDLE)
