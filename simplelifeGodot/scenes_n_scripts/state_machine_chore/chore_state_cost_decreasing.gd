class_name ChoreStateCostDecreasing
extends State

@export var chore: ChoreBase
## Keeps count of time towards motivation_tick_duration
var motivation_cost_ticker: float = 0


func process(delta: float) -> void:
	while motivation_cost_ticker > chore.motivation_tick_duration:
		motivation_cost_ticker -= chore.motivation_tick_duration
		chore.current_motivation_cost -= 1
		# Motivation cost can never be under 1
		chore.current_motivation_cost = max(chore.current_motivation_cost, 1)
		# We use -1 so that when the bar goes to 1, the fill will be empty since
		# 1 is the lowest possible number.
		chore.motivation_cost_bar.value = chore.current_motivation_cost - 1
		chore.label.text = str(chore.current_motivation_cost)
	motivation_cost_ticker += delta


func enter_state(_previous_state: State):
	motivation_cost_ticker = 0
	chore.current_motivation_cost = chore.max_motivation_cost
	chore.motivation_cost_bar.max_value = chore.max_motivation_cost
	chore.motivation_cost_bar.value = chore.max_motivation_cost
	chore.label.text = str(chore.max_motivation_cost)
	chore.motivation_cost_bar.get("theme_override_styles/fill").bg_color = Color.FOREST_GREEN
