class_name SectionSummaryGridStateDisabled
extends SectionSummaryGridState

func _enter_tree() -> void:
	Logger.debug("%s is now disabled" % _section_summary_grid.name)
