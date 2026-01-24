class_name DigitSpinnerStateIdle
extends DigitSpinnerState

# TODO: this is unnecessary once the spinner is inside the amount entry modal
const MAPPING_CONTEXT: GUIDEMappingContext = preload(
	"res://resources/input/ctx_new_transaction_modal_acting.tres")

func _enter_tree() -> void:
	Logger.debug("%s is now idle" % _digit_spinner.name)

	GUIDE.enable_mapping_context(MAPPING_CONTEXT)

	_appearance.for_idle()

	SignalHelper.persist(
		ConfirmCancelInput.confirm,
		transition_state.bind(DigitSpinner.State.ACTIVE)
	)
