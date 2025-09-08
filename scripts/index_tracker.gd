class_name IndexTracker

var _maximum := -1
var _current := 0

func _init(maximum: int) -> void:
	assert(maximum >= 0)

	_maximum = maximum

func next() -> int:
	_current = mini(_maximum, _current + 1)
	return _current

func previous() -> int:
	_current = maxi(0, _current - 1)
	return _current

func current() -> int:
	return _current
