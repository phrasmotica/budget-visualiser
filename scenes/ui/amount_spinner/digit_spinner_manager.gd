@tool
class_name DigitSpinnerManager
extends Node

@export
var major_spinner_parent: HBoxContainer

@export
var minor_spinner_parent: HBoxContainer

@export
var digit_spinners: Array[DigitSpinner] = []

var _highlighted_index := -1

signal amount_changed(amount: float)
signal highlighted_spinner_changed(spinner: DigitSpinner)

func refresh_all_spinners(
	spinner_owner: Control,
	major_count: int,
	minor_count: int,
) -> void:
	digit_spinners.clear()

	_refresh_spinners(major_spinner_parent, spinner_owner, major_count)
	_refresh_spinners(minor_spinner_parent, spinner_owner, minor_count)

func _refresh_spinners(
	spinner_parent: Control,
	spinner_owner: Control,
	count: int,
) -> void:
	var major_child_count := spinner_parent.get_child_count()

	for i in count:
		var spinner: DigitSpinner

		if i >= major_child_count:
			spinner = DigitSpinnerFactory.create_spinner(i)

			spinner_parent.add_child(spinner)
			spinner.owner = spinner_owner
		else:
			spinner = spinner_parent.get_child(i)

		SignalHelper.persist(
			spinner.amount_changed,
			_on_spinner_amount_changed)

		digit_spinners.append(spinner)

	while spinner_parent.get_child_count() > count:
		var child := spinner_parent.get_child(count)
		spinner_parent.remove_child(child)

func _on_spinner_amount_changed() -> void:
	var new_amount := get_amount()
	amount_changed.emit(new_amount)

func highlight(index: int) -> DigitSpinner:
	if index < 0 or index > digit_spinners.size() - 1:
		Logger.info("Cannot highlight DigitSpinner at invalid index %d!" % index)
		return

	_highlighted_index = index

	for i in digit_spinners.size():
		if i == _highlighted_index:
			digit_spinners[i].highlight()
		else:
			digit_spinners[i].unhighlight()

	highlighted_spinner_changed.emit(digit_spinners[index])

	return digit_spinners[index]

func get_amount() -> float:
	var total := 0.0

	var spinner_count := digit_spinners.size()

	for i in spinner_count:
		var spinner := digit_spinners[i]

		var power := spinner_count - 3 - i
		total += spinner.amount * pow(10, power)

	return total

func set_amount(amount: float) -> void:
	var digits := Math.digits_of(amount)

	var spinner_count := digit_spinners.size()
	var digits_count := digits.size()

	if spinner_count > digits_count:
		for i in spinner_count - digits_count:
			digits.push_front(0)
	elif spinner_count < digits_count:
		digits = digits.slice(digits_count - spinner_count)

	for i in spinner_count:
		digit_spinners[i].amount = digits[i]

func reset_appearance() -> void:
	# will highlight the 1's column
	highlight(digit_spinners.size() - 3)

func next_column() -> void:
	highlight(_highlighted_index + 1)

func previous_column() -> void:
	highlight(_highlighted_index - 1)
