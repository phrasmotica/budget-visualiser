class_name AmountEntryModalStateData

var _sub_header := ""
var _amount := 0.0
var _starting_amount := 0.0

static func build() -> AmountEntryModalStateData:
	return AmountEntryModalStateData.new()

func with_sub_header(sub_header: String) -> AmountEntryModalStateData:
	_sub_header = sub_header
	return self

func get_sub_header() -> String:
	return _sub_header

func with_amount(amount: float) -> AmountEntryModalStateData:
	_amount = amount
	return self

func get_amount() -> float:
	return _amount

func with_starting_amount(starting_amount: float) -> AmountEntryModalStateData:
	_starting_amount = starting_amount
	return self

func get_starting_amount() -> float:
	return _starting_amount
