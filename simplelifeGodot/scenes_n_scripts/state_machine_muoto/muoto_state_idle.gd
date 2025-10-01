class_name MuotoStateIdle
extends State

@export var muoto: Muoto


func process(_delta: float) -> void:
	muoto.buy_chore_with_motivation_if_possible()


func enter_state(_previous_state: State):
	if muoto.current_chore != null:
		## TODO: Use signals.
		muoto.current_chore.change_state(ChoreBase.ChoreState.IN_COOLDOWN)
		muoto.current_chore = null
	muoto.sprite.play("idle_wide")
