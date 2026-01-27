class_name EditableLabelStateData

var _text := ""

static func build() -> EditableLabelStateData:
	return EditableLabelStateData.new()

func with_text(text: String) -> EditableLabelStateData:
	_text = text
	return self

func get_text() -> String:
	return _text
