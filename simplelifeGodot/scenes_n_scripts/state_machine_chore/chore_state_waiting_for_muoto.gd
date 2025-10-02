extends State

@export var chore: ChoreBase


func enter_state(_previous_state: State):
	chore.motivation_cost_bar.value = chore.max_motivation_cost
	chore.motivation_cost_bar.get("theme_override_styles/fill").bg_color = Color.DARK_KHAKI
	chore.label.text = str("WAITING")
