class_name MuotoStateGoingToChore
extends State

@export var muoto: Muoto


func process(delta: float) -> void:
	if(muoto.move_towards_target(delta)):
		muoto.state_machine.change_state(muoto.state_doing_chore)


func enter_state(_previous_state: State):
	muoto.current_chore.state_machine.change_state(muoto.current_chore.chore_state_waiting_for_muoto)
	muoto.sprite.play("walk")
