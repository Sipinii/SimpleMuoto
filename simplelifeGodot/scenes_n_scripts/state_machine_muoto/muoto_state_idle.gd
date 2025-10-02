class_name MuotoStateIdle
extends State

@export var muoto: Muoto


func process(_delta: float) -> void:
	muoto.buy_chore_with_motivation_if_possible()


func enter_state(_previous_state: State):
	if muoto.current_chore != null:
		## TODO: Use signals.
		muoto.current_chore.state_machine.change_state(muoto.current_chore.chore_state_in_cooldown)
		muoto.current_chore = null
	muoto.sprite.play("idle_wide")
