class_name ChoreBase
extends Node2D

@export_group("General")
## Max cooldown time in seconds.
@export var max_cooldown: int = 5
@export var cooldown_tick_duration: float = 1
#var current_cooldown: int
@export var max_motivation_cost: int = 10
## How long does it take for the motivation to decrease?
@export var motivation_tick_duration: float = 1
## X position that Muoto uses as its target when moving to the Chore.
@export_group("Visuals")
@export var cost_decreasing_color: float = 0
@export_group("State Refs")
@export var chore_state_cost_decreasing: State
@export var chore_state_in_cooldown: State
@export var chore_state_waiting_for_muoto: State
@export var chore_state_in_muoto_interaction: State
@export_group("Other Internal Refs")
@export var chore_sprite: Sprite2D
@export var motivation_cost_bar: ProgressBar
@export var label: Label
@export var clickable_area: ClickableArea
@export var muoto_target_pos: Node2D
@export var state_machine: StateMachine

var is_being_acted_upon: bool = false
var current_motivation_cost: int = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Material needs to be duplicated, otherwise changing the material in one instance
	# will change the material in all the other instances which use the same material.
	chore_sprite.material = chore_sprite.material.duplicate()
	# Progress bar fill material also needs to be duplicated.
	# TODO: For whatever reason this doesn't work. Fix.
	var bar_fill_style: StyleBoxFlat = motivation_cost_bar.get_theme_stylebox("fill")
	bar_fill_style = bar_fill_style.duplicate()
	motivation_cost_bar.add_theme_stylebox_override("fill", bar_fill_style)
	motivation_cost_bar.max_value = max_motivation_cost
	motivation_cost_bar.value = max_motivation_cost
	label.text = str(max_motivation_cost)
	# We want the motivation cost bar to be only visible when hovering over the sprite.
	motivation_cost_bar.visible = false
	#motivation_cost_bar.get("theme_override_styles/fill").bg_color = Color.FOREST_GREEN
	clickable_area.mouse_entered_area.connect(_on_clickable_area_mouse_entered_area)
	clickable_area.mouse_exited_area.connect(_on_clickable_area_mouse_exited_area)



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
