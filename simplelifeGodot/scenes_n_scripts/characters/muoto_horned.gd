class_name Muoto
extends AnimatableBody2D

@export_group("State Node Internal Refs")
@export var state_idle: State
@export var state_going_to_chore: State
@export var state_doing_chore: State
@export_group("Other Internal Refs")
@export var sprite: AnimatedSprite2D
@export var debug_label: Label
@export var state_machine: StateMachine
@export_group("External Refs")
@export var motivation_bar: MotivationBar
@export var chore_manager: ChoreManager


## NOTE: Call change_state instead of setting this directly.
var walk_speed: float = 20
var current_chore: ChoreBase

func _ready() -> void:
	state_machine.state_changed.connect(_on_state_changed)

## Returns true when target has been reached.
func move_towards_target(delta: float) -> bool:
	var max_movement_distance: float = delta * walk_speed
	var x_offset_to_target = current_chore.muoto_target_pos.global_position.x - global_position.x
	# Flip the sprite based on movement dir.
	sprite.flip_h = x_offset_to_target < 0
	if abs(x_offset_to_target) <= max_movement_distance:
		global_position.x += x_offset_to_target
		return true
	global_position.x += max_movement_distance * sign(x_offset_to_target)
	return false


func buy_chore_with_motivation_if_possible() -> void:
	var lowest_cost_chore: ChoreBase = chore_manager.chore_with_lowest_m_cost()
	if lowest_cost_chore != null:
		if lowest_cost_chore.current_motivation_cost <= motivation_bar.motivation_points:
			motivation_bar.subtract_motivation_points(lowest_cost_chore.current_motivation_cost)
			current_chore = lowest_cost_chore
			state_machine.change_state(state_going_to_chore)


func _on_state_changed(_previous: State, new: State) -> void:
	debug_label.text = new.name
