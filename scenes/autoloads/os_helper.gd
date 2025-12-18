class_name OSHelper

var _is_windows := false
var _is_macos := false

func _init() -> void:
	var os_name := OS.get_name()
	Logger.info("OS: %s" % os_name)

	_is_windows = os_name.contains("Windows")
	Logger.info("OS is Windows: %s" % _is_windows)

	_is_macos = os_name.contains("macOS")
	Logger.info("OS is macOS: %s" % _is_macos)

	assert(_is_windows != _is_macos)

func is_windows() -> bool:
	return _is_windows

func is_macos() -> bool:
	return _is_macos
