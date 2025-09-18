extends Node

signal primary_click_pressed
signal primary_click_released

var is_primary_click_held_down: bool = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("click_primary"):
		is_primary_click_held_down = true
		emit_signal("primary_click_pressed")
		print("Input manager: primary click pressed.")
	elif event.is_action_released("click_primary"):
		is_primary_click_held_down = false
		emit_signal("primary_click_released")
		print("Input manager: primary click released.")


func get_is_primary_click_held_down() -> bool:
	return is_primary_click_held_down
