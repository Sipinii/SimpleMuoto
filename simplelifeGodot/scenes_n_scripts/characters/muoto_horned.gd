class_name Muoto
extends AnimatableBody2D

enum MuotoState {
	IDLE,
	GOING_TO_CHORE,
	DOING_CHORE,
}

@export var sprite: AnimatedSprite2D
@export var motivation_bar: MotivationBar
@export var debug_label: Label

## NOTE: Call change_state instead of setting this directly.
var muoto_state: MuotoState = MuotoState.IDLE
var walk_speed: float = 20
var current_chore: ChoreBase

func _ready() -> void:
	var state_name = MuotoState.keys()[MuotoState.values().find(muoto_state)]
	debug_label.text = str(state_name)


func _physics_process(delta: float) -> void:
	match muoto_state:
		MuotoState.IDLE:
			physics_process_idle(delta)
		MuotoState.GOING_TO_CHORE:
			physics_move_towards(delta, current_chore.global_position.x)
		MuotoState.DOING_CHORE:
			pass
		_:
			push_error("Unknown state!")


func change_state(new_state: MuotoState) -> void:
	if(new_state == muoto_state):
		print("Tried to change to the current Muoto state: " + str(muoto_state))
	match muoto_state:
		MuotoState.IDLE:
			sprite.play("idle_wide")
		MuotoState.GOING_TO_CHORE:
			print("New target pos: " + str(position))
			sprite.play("walk")
		MuotoState.DOING_CHORE:
			pass
		_:
			push_error("Unknown state!")
	muoto_state = new_state
	var state_name = MuotoState.keys()[MuotoState.values().find(muoto_state)]
	debug_label.text = str(state_name)


func physics_move_towards(delta: float, target_pos: float) -> void:
	var new_pos = global_position.move_toward(Vector2(target_pos, global_position.y), walk_speed * delta)
	global_position.x += delta * walk_speed
	print("Muotos pos: " + str(global_position.x))


func physics_process_idle(delta: float) -> void:
	
	pass


func buy_chore_with_motivation_if_possible(chore: ChoreBase) -> void:
	# TODO: If the current state is ok for buying a chore, then:
	if chore.current_motivation_cost <= motivation_bar.motivation_points:
		motivation_bar.subtract_motivation_points(chore.current_motivation_cost)
		chore.change_state(ChoreBase.ChoreState.WAITING_FOR_MUOTO)
		current_chore = chore
		muoto_state = MuotoState.GOING_TO_CHORE
	# TODO: Have muoto enter "going to chore" state.
