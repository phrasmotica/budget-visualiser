class_name CycleTracker

var _name := ""
var _maximum := -1
var _current := 0

func _init(maximum: int, name: String) -> void:
	_name = name

	assert(maximum >= 0)

	_maximum = maximum

func cycle() -> int:
	_current += 1

	if _current >= _maximum:
		_current = 0

	_report()
	return _current

func current() -> int:
	_report()
	return _current

func _report() -> void:
	CustomLogger.debug("%s _current=%d" % [_name, _current])
