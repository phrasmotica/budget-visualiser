class_name DigitSpinnerFactory

const GRID_SCENE := preload("res://scenes/ui/digit_spinner/digit_spinner.tscn")

static func create_spinner(index: int) -> DigitSpinner:
	var spinner: DigitSpinner = GRID_SCENE.instantiate()
	spinner.name = "DigitSpinner%d" % index

	return spinner
