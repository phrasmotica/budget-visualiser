class_name YearGridStateData

var _entered_amount := 0.0

static func build() -> YearGridStateData:
	return YearGridStateData.new()

func with_entered_amount(entered_amount: float) -> YearGridStateData:
	_entered_amount = entered_amount
	return self

func get_entered_amount() -> float:
	return _entered_amount
