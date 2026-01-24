@tool
class_name DigitSpinnerManager
extends Node

@export
var spinner_parent: HBoxContainer

@export
var digit_spinners: Array[DigitSpinner] = []

var _highlighted_index := -1

signal highlighted_spinner_changed(spinner: DigitSpinner)

func refresh_spinners(
	spinner_owner: Control,
	count: int,
) -> void:
	var child_count := spinner_parent.get_child_count()

	digit_spinners.clear()

	for i in count:
		var spinner: DigitSpinner

		if i >= child_count:
			spinner = DigitSpinnerFactory.create_spinner(i)

			spinner_parent.add_child(spinner)
			spinner.owner = spinner_owner
		else:
			spinner = spinner_parent.get_child(i)

		digit_spinners.append(spinner)

	while spinner_parent.get_child_count() > count:
		var child := spinner_parent.get_child(count)
		spinner_parent.remove_child(child)

func highlight(index: int) -> DigitSpinner:
	if index < 0 or index > digit_spinners.size() - 1:
		Logger.info("Cannot highlight DigitSpinner at invalid index %d!" % index)
		return

	_highlighted_index = index

	for i in digit_spinners.size():
		digit_spinners[i].enable()

		if i == _highlighted_index:
			digit_spinners[i].highlight()
		else:
			digit_spinners[i].unhighlight()

	highlighted_spinner_changed.emit(digit_spinners[index])

	return digit_spinners[index]
