class_name Strings

static func join(delimiter: String) -> Callable:
	return (
		func(a: String, b: String) -> String:
			return a + delimiter + b
	)

static func curr(amount: float) -> String:
	return "£%.2f" % amount

static func curr_map(format: String, amounts: Array[float]) -> String:
	return format % amounts.map(curr)
