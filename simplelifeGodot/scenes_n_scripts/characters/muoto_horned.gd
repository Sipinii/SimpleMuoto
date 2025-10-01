class_name Muoto
extends AnimatableBody2D

enum MuotoState {
	IDLE,
	GOING_TO_CHORE,
	DOING_CHORE,
}

@export_group("Internal Refs")
@export var sprite: AnimatedSprite2D
@export var debug_label: Label
@export_group("External Refs")
@export var motivation_bar: MotivationBar
@export var chore_manager: ChoreManager


## NOTE: Call change_state instead of setting this directly.
var muoto_state: MuotoState = MuotoState.IDLE
var walk_speed: float = 20
var current_chore: ChoreBase


func _ready() -> void:
	var state_name = MuotoState.keys()[MuotoState.values().find(muoto_state)]
	debug_label.text = str(state_name)


func _process(delta: float) -> void:
	match muoto_state:
		MuotoState.IDLE:
			process_idle()
		MuotoState.GOING_TO_CHORE:
			if(move_towards_target(delta)):
				change_state(MuotoState.DOING_CHORE)
				return
		MuotoState.DOING_CHORE:
			pass
		_:
			push_error("Unknown state!")


func change_state(new_state: MuotoState) -> void:
	if(new_state == muoto_state):
		push_warning("Tried to change to the current Muoto state: " + str(muoto_state))
		return
	# Exit state functionality.
	match muoto_state:
		MuotoState.IDLE:
			pass
		MuotoState.GOING_TO_CHORE:
			pass
		MuotoState.DOING_CHORE:
			pass
		_:
			push_error("Unknown state!")
	# Enter state functionality.
	match new_state:
		MuotoState.IDLE:
			if current_chore != null:
				## TODO: Use signals.
				current_chore.change_state(ChoreBase.ChoreState.IN_COOLDOWN)
				current_chore = null
			sprite.play("idle_wide")
		MuotoState.GOING_TO_CHORE:
			current_chore.change_state(ChoreBase.ChoreState.WAITING_FOR_MUOTO)
			sprite.play("walk")
		MuotoState.DOING_CHORE:
			current_chore.change_state(ChoreBase.ChoreState.IN_MUOTO_INTERACTION)
			do_chore()
			sprite.play("idle")
		_:
			push_error("Unknown state!")
	muoto_state = new_state
	var state_name = MuotoState.keys()[MuotoState.values().find(muoto_state)]
	debug_label.text = str(state_name)


func process_idle() -> void:
	buy_chore_with_motivation_if_possible()


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
			change_state(MuotoState.GOING_TO_CHORE)


func do_chore() -> void:
	# TODO: This is risky because this function should be cancelled if state is changed
	# elsewhere before the timer runs out.
	await get_tree().create_timer(2.0).timeout
	change_state(MuotoState.IDLE)
	pass
