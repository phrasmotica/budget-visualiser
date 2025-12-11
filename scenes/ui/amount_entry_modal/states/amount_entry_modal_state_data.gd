class_name AmountEntryModalStateData

var _category: BudgetCategory
var _month: BudgetMonth
var _amount := 0.0
var _starting_amount := 0.0

static func build() -> AmountEntryModalStateData:
	return AmountEntryModalStateData.new()

func with_category(category: BudgetCategory) -> AmountEntryModalStateData:
	_category = category
	return self

func get_category() -> BudgetCategory:
	return _category

func with_month(month: BudgetMonth) -> AmountEntryModalStateData:
	_month = month
	return self

func get_month() -> BudgetMonth:
	return _month

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
