extends AnimatableBody2D


var walk_speed: float = 100
var target_pos: Vector2 = Vector2.ZERO
var moving_to_target_pos = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	if moving_to_target_pos:
		physics_move_towards(delta)
	pass

func physics_move_towards(delta: float) -> void:
	var new_pos = global_position.move_toward(target_pos, walk_speed * delta)
	global_position.x += delta * walk_speed
	print(global_position.x)
	pass
