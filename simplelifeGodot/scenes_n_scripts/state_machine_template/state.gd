class_name State
extends Node
## Class used by the StateMachine class. These functions are meant to be overridden
## in the actual state classes which inherit from this.


func process(_delta: float) -> void:
	pass


func physics_process(_delta: float) -> void:
	pass


func unhandled_input(_event: InputEvent) -> void:
	pass


func enter_state(_previous_state: State):
	pass


func exit_state():
	pass
