class_name MuotoStateGoingToChore
extends State

@export var muoto: Muoto


func process(delta: float) -> void:
	if(muoto.move_towards_target(delta)):
		muoto.state_machine.change_state(muoto.state_doing_chore)


func enter_state(_previous_state: State):
	muoto.current_chore.change_state(ChoreBase.ChoreState.WAITING_FOR_MUOTO)
	muoto.sprite.play("walk")
