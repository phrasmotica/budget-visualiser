@tool
class_name CategoryLabels
extends VBoxContainer

const LABEL_MIN_HEIGHT := 60.0
const LABEL_FONT_SIZE := 32

@export
var section: BudgetSection:
	set(value):
		section = value

		SignalHelper.on_changed(section, _refresh)

		call_deferred("_refresh")

func _refresh() -> void:
	var categories: Array[BudgetCategory] = []
	if section:
		categories = section.categories

	var child_count := get_child_count()

	for i in categories.size():
		var new_text := "<Category%d>" % i

		var category := categories[i]
		if category:
			new_text = category.name

		var label: Label

		if i >= child_count:
			label = CategoryLabelFactory.create_label(i)

			add_child(label)
			label.owner = self
		else:
			label = get_child(i) as Label

		label.text = new_text

	while get_child_count() > categories.size():
		remove_child(get_child(categories.size()))
