class_name State
extends Node
## Class used by the StateMachine class. These functions are meant to be overridden
## in the actual state classes which inherit from this.


func ready() -> void:
	pass


func process(delta: float) -> void:
	pass


func physics_process(delta: float) -> void:
	pass


func unhandled_input(event: InputEvent) -> void:
	pass


func enter_state(previous_state: State, params: Dictionary):
	pass


func exit_state():
	pass
