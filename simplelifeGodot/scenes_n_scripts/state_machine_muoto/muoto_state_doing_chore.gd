class_name MuotoStateDoingChore
extends State

@export var muoto: Muoto

var _timer: float = 0 


func process(_delta: float) -> void:
	if _timer > 2.0:
		muoto.state_machine.change_state(muoto.state_idle)
	_timer += _delta


func enter_state(_previous_state: State):
	_timer = 0
	muoto.current_chore.change_state(ChoreBase.ChoreState.IN_MUOTO_INTERACTION)
	muoto.sprite.play("idle")
