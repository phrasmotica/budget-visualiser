class_name TransactionListerModalStateActing
extends TransactionListerModalState

const MAPPING_CONTEXT: GUIDEMappingContext = preload(
	"res://resources/input/ctx_transaction_lister_modal_acting.tres")

func _enter_tree() -> void:
	Logger.debug("%s is now acting" % _transaction_lister_modal.name)

	GUIDE.enable_mapping_context(MAPPING_CONTEXT)

	_transaction_lister_modal.show()

	_modal_buttons.deactivate()

	if not _state_data.get_skip_transactions():
		_transaction_lister.transactions = _state_data.get_transactions()

	_transaction_lister.enable()

	SignalHelper.persist(ConfirmCancelInput.cancel, _cancel)

	SignalHelper.persist(NavigationInput.next_section, _to_finishing)

func _exit_tree() -> void:
	GUIDE.disable_mapping_context(MAPPING_CONTEXT)

func disable() -> void:
	_to_hidden()

func _cancel() -> void:
	Logger.info("Cancelled toggling transactions")

	_transaction_lister.disable()

	TransactionListerEvents.emit_cancelled()

	_to_hidden()

func _to_finishing() -> void:
	_transaction_lister.disable()

	transition_state(TransactionListerModal.State.FINISHING)

func _to_hidden() -> void:
	transition_state(TransactionListerModal.State.HIDDEN)
