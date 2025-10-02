extends State

@export var chore: ChoreBase
var cooldown_ticker: float = 0
var current_cooldown: int = 0


func enter_state(_previous: State) -> void:
	chore.motivation_cost_bar.get("theme_override_styles/fill").bg_color = Color.CYAN
	cooldown_ticker = 0
	current_cooldown = chore.max_cooldown
	chore.label.text = str("COOLING")
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func process(delta: float) -> void:
	while cooldown_ticker > chore.cooldown_tick_duration:
		cooldown_ticker -= chore.cooldown_tick_duration
		current_cooldown -= 1
		chore.motivation_cost_bar.value = current_cooldown
	cooldown_ticker += delta
	chore.label.text = str("COOLING")
	if current_cooldown <= 0:
		chore.state_machine.change_state(chore.chore_state_cost_decreasing)
