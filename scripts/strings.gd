class_name Strings

static func join(delimiter: String) -> Callable:
	return (
		func(a: String, b: String) -> String:
			return a + delimiter + b
	)
