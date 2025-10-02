class_name StateMachine
extends Node
## Hierarchical State machine for the player.
##
## Initializes states and delegates engine callbacks ([method Node._physics_process],
## [method Node._unhandled_input]) to the state.

signal state_changed(previous, new)

@export var _initial_state: State
## Use this to pause the callback functions of the state machine.
var is_active: bool = true:
		set = set_is_active
var _is_in_state_change = false

@onready var _current_state: State = _initial_state


func _ready():
	_current_state.enter_state(null)


func _unhandled_input(event):
	if not is_active:
		return
	_current_state.unhandled_input(event)


func _process(delta):
	if not is_active:
		return
	_current_state.process(delta)


func _physics_process(delta):
	if not is_active:
		return
	_current_state.physics_process(delta)


func change_state(new_state: State):
	assert(new_state, "Null state parameter.")
	assert(not _is_in_state_change, "Tried to change to state: " + new_state.name
			+ " while already in a state change.")
	_is_in_state_change = true
	assert(new_state is State, "New state must inherit of type State")
	_current_state.exit_state()
	new_state.enter_state(_current_state)
	# NOTE: The _current_state is still the previous state here.
	state_changed.emit(_current_state, new_state)
	self._current_state = new_state
	_is_in_state_change = false


func set_is_active(value):
	is_active = value
	set_process(value)
	set_physics_process(value)
	set_process_unhandled_input(value)
	set_block_signals(not value)

func current_state() -> State:
	return _current_state
