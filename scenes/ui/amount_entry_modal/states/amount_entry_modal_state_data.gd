class_name AmountEntryModalStateData

var _amount := 0.0

static func build() -> AmountEntryModalStateData:
	return AmountEntryModalStateData.new()

func with_amount(amount: float) -> AmountEntryModalStateData:
	_amount = amount
	return self

func get_amount() -> float:
	return _amount
