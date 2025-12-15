class_name IndexTracker

var _name := ""
var _maximum := -1
var _current := 0

func _init(maximum: int, name: String) -> void:
	_name = name

	assert(maximum >= 0)

	_maximum = maximum

func next() -> int:
	_current = mini(_maximum, _current + 1)
	_report()
	return _current

func previous() -> int:
	_current = maxi(0, _current - 1)
	_report()
	return _current

func current() -> int:
	_report()
	return _current

func last() -> int:
	_current = _maximum
	_report()
	return _current

func first() -> int:
	_current = 0
	_report()
	return _current

func is_last() -> bool:
	return _current == _maximum

func _report() -> void:
	print("%s _current=%d" % [_name, _current])
