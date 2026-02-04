class_name SectionChangeTracker

var _section: BudgetSection = null

# TODO: key the name changes by category ID instead. For which we'll need to
# assign an ID to each category...
var _changes_category_names: Dictionary[String, String] = {}

func _init(section: BudgetSection) -> void:
	_section = section

func change_category_name(old_name: String, new_name: String) -> String:
	if not _has_category(old_name):
		Logger.warn("No category \"%s\" exists!" % old_name)
		return ""

	Logger.debug("Category name change: %s->%s" % [old_name, new_name])

	_changes_category_names[old_name] = new_name

	return new_name

func _has_category(category_name: String) -> bool:
	return _section.categories.any(
		func(c: BudgetCategory) -> bool:
			return c.name == category_name
	)

func get_section() -> BudgetSection:
	return _section

func get_new_category_name(category: BudgetCategory) -> String:
	if not _changes_category_names.has(category.name):
		return category.name

	return _changes_category_names[category.name]

func get_new_category_names_summary() -> String:
	var new_names := _changes_category_names.values()
	if not new_names:
		return ""

	return new_names.reduce(Strings.join(", "))

func clear_changes() -> void:
	_changes_category_names.clear()
