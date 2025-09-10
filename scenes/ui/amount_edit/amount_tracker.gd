class_name AmountTracker

var _minimum := 0
var _maximum := 1000

var _current := 0

func _init(minimum: int, maximum: int) -> void:
	_minimum = minimum
	_maximum = maximum

func current() -> int:
	return _current

func set_current(amount: int) -> int:
	_current = clampi(amount, _minimum, _maximum)
	return _current

func add(change: int) -> int:
	_current = mini(_maximum, _current + change)
	return _current

func subtract(change: int) -> int:
	_current = maxi(_minimum, _current - change)
	return _current
