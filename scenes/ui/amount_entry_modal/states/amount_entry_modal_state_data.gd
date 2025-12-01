class_name AmountEntryModalStateData

var _sub_header := ""
var _amount := 0.0

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
