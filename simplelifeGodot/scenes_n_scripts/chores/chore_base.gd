class_name ChoreBase
extends Node2D

enum ChoreState {
	IN_COOLDOWN,
	COST_DECREASING,
	WAITING_FOR_MUOTO,
	IN_MUOTO_INTERACTION,
}

@export_group("General")
## Max cooldown time in seconds.
@export var max_cooldown: int = 100
#var current_cooldown: int
@export var max_motivation_cost: int = 100
## How long does it take for the motivation to decrease?
@export var motivation_tick_duration: float = 1
## X position that Muoto uses as its target when moving to the Chore.
## TODO: Change this to a node so that its easier to set the postition.
@export var muoto_target_x_pos: float = 0
@export_group("Visuals")
@export var cost_decreasing_color: float = 0
@export_group("Internal Refs")
@export var chore_sprite: Sprite2D
@export var motivation_cost_bar: ProgressBar
@export var label: Label
@export var clickable_area: ClickableArea

var current_state := ChoreState.COST_DECREASING
var current_motivation_cost: int
var is_being_acted_upon: bool = false
## Keeps count of time towards motivation_tick_duration
var motivation_cost_ticker: float = 0
var cooldown_ticker: float = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Material needs to be duplicated, otherwise changing the material in one instance
	# will change the material in all the other instances which use the same material.
	chore_sprite.material = chore_sprite.material.duplicate()
	current_motivation_cost = max_motivation_cost
	motivation_cost_bar.max_value = max_motivation_cost
	motivation_cost_bar.value = max_motivation_cost
	label.text = str(max_motivation_cost)
	# We want the motivation cost bar to be only visible when hovering over the sprite.
	motivation_cost_bar.visible = false
	motivation_cost_bar.get("theme_override_styles/fill").bg_color = Color.FOREST_GREEN
	clickable_area.mouse_entered_area.connect(_on_clickable_area_mouse_entered_area)
	clickable_area.mouse_exited_area.connect(_on_clickable_area_mouse_exited_area)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match current_state:
		ChoreState.IN_COOLDOWN:
			process_in_cooldown(delta)
		ChoreState.COST_DECREASING:
			process_cost_decreasing(delta)
		ChoreState.WAITING_FOR_MUOTO:
			#process_waiting_for_muoto(delta)
			pass
		ChoreState.IN_MUOTO_INTERACTION:
			#process_muoto_interaction(delta)
			pass
		_:
			push_error("Unknown state!")


func _on_clickable_area_mouse_entered_area() -> void:
	var mat = chore_sprite.material as ShaderMaterial
	mat.set_shader_parameter("flash_value", 0.3)
	motivation_cost_bar.visible = true
	pass # Replace with function body.


func _on_clickable_area_mouse_exited_area() -> void:
	var mat = chore_sprite.material as ShaderMaterial
	mat.set_shader_parameter("flash_value", 0.0)
	motivation_cost_bar.visible = false
	pass # Replace with function body.


func change_state(new_state: ChoreState) -> void:
	if(new_state == current_state):
		print("Tried to change to same state this was already in: " + str(current_state))
	# Exit state functionality.
	match current_state:
		ChoreState.IN_COOLDOWN:
			pass
		ChoreState.COST_DECREASING:
			pass
		ChoreState.WAITING_FOR_MUOTO:
			pass
		ChoreState.IN_MUOTO_INTERACTION:
			pass
		_:
			push_error("Unknown state!")
	# Enter state functionality.
	match new_state:
		ChoreState.IN_COOLDOWN:
			motivation_cost_bar.get("theme_override_styles/fill").bg_color = Color.CYAN
			cooldown_ticker = 0
			label.text = str("COOLING")
			pass
		ChoreState.COST_DECREASING:
			motivation_cost_ticker = 0
			current_motivation_cost = max_motivation_cost
			motivation_cost_bar.max_value = max_motivation_cost
			motivation_cost_bar.value = max_motivation_cost
			label.text = str(max_motivation_cost)
			motivation_cost_bar.get("theme_override_styles/fill").bg_color = Color.FOREST_GREEN
			pass
		ChoreState.WAITING_FOR_MUOTO:
			motivation_cost_bar.value = max_motivation_cost
			motivation_cost_bar.get("theme_override_styles/fill").bg_color = Color.DARK_KHAKI
			label.text = str("WAITING")
			pass
		ChoreState.IN_MUOTO_INTERACTION:
			motivation_cost_bar.get("theme_override_styles/fill").bg_color = Color.DARK_ORANGE
			label.text = str("ACTING")
			pass
		_:
			push_error("Unknown state!")
	current_state = new_state
	pass


func process_in_cooldown(delta: float) -> void:
	cooldown_ticker += delta
	label.text = str("ACTING")


## State update when motivation cost decreases.
func process_cost_decreasing(delta: float) -> void:
	while motivation_cost_ticker > motivation_tick_duration:
		motivation_cost_ticker -= motivation_tick_duration
		current_motivation_cost -= 1
		# Motivation cost can never be under 1
		current_motivation_cost = max(current_motivation_cost, 1)
		motivation_cost_bar.value = current_motivation_cost
		label.text = str(current_motivation_cost)
	motivation_cost_ticker += delta
	pass


#func process_waiting_for_muoto(delta: float) -> void:
	#pass


#func process_in_muoto_interaction(delta: float) -> void:
	#pass
