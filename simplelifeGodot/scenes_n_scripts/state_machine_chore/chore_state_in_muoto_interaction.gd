extends State

@export var chore: ChoreBase


func enter_state(_previous_state: State):
	chore.motivation_cost_bar.get("theme_override_styles/fill").bg_color = Color.DARK_ORANGE
	chore.label.text = str("ACTING")
	pass
