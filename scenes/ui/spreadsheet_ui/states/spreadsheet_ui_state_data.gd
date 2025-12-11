class_name SpreadsheetUIStateData

var _entered_amount := -1.0

static func build() -> SpreadsheetUIStateData:
	return SpreadsheetUIStateData.new()

func with_entered_amount(entered_amount: float) -> SpreadsheetUIStateData:
	_entered_amount = entered_amount
	return self

func get_entered_amount() -> float:
	return _entered_amount
