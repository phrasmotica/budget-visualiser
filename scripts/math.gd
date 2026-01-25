class_name Math

static func sum(a: float, b: float) -> float:
	return a + b

# returns a list of
static func digits_of(x: float) -> Array[int]:
	var number_str := "%.2f" % x

	var digits: Array[int] = []

	for c in number_str:
		if c.is_valid_int():
			digits.append(int(c))

	return digits
