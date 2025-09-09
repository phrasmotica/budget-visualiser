class_name AmountEntryModalAppearance
extends Node

@export
var edit_major: AmountEdit

@export
var edit_minor: AmountEdit

func for_shown() -> void:
	if edit_major:
		edit_major.enable()

	if edit_minor:
		edit_minor.disable()
