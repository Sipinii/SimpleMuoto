class_name MotivationBar
extends Node

@export var motivation_bar_clickable_area: ClickableArea
@export var star_button_clickable_area: ClickableArea

var sprites: Array 
var label_og_y_pos: float
var motivation_points: int = 0:
	set(value):
		motivation_points = value
		label.text = str(motivation_points) + " m"
		#print("Added " + str(value) + " motivation points. Motivation is now: " + str(motivation_points))

@onready var bar_down: Sprite2D = $MotivationBarDown
@onready var bar_up: Sprite2D = $MotivationBarUp
@onready var star_button_down: Sprite2D = $StarButtonDown
@onready var star_button_up: Sprite2D = $StarButtonUp
@onready var label: Label = $MotivationPointAmount


func _ready() -> void:
	sprites = [bar_down, bar_up, star_button_down, star_button_up]
	label_og_y_pos = label.position.y
	InputManager.primary_click_released.connect(_on_primary_click_released)
	star_button_clickable_area.clicked.connect(_on_star_button_clicked)
	motivation_bar_clickable_area.clicked.connect(_on_motivation_bar_clicked)
	motivation_bar_clickable_area.mouse_entered_area.connect(_on_motivation_bar_mouse_entered)
	motivation_bar_clickable_area.mouse_exited_area.connect(_on_motivation_bar_mouse_exited)


func _on_star_button_clicked() -> void:
	star_button_up.visible = false
	#var mat = bar_up.material as ShaderMaterial
	#mat.set_shader_parameter("flash_value", 0.0)
	add_motivation_points(1)


func _on_motivation_bar_clicked() -> void:
	bar_up.visible = false
	star_button_up.visible = false
	label.position = Vector2(label.position.x, label.position.y + 2)
	#var mat = bar_up.material as ShaderMaterial
	#mat.set_shader_parameter("flash_value", 0.0)
	add_motivation_points(1)


func _on_motivation_bar_mouse_entered() -> void:
	#var mat = bar_up.material as ShaderMaterial
	#mat.set_shader_parameter("flash_value", 0.3)
	pass # Replace with function body.


func _on_motivation_bar_mouse_exited() -> void:
	#var mat = bar_up.material as ShaderMaterial
	#mat.set_shader_parameter("flash_value", 0.0)
	pass # Replace with function body.


func _on_primary_click_released() -> void:
	bar_up.visible = true
	star_button_up.visible = true
	star_button_down.visible = true
	label.position = Vector2(label.position.x, label_og_y_pos)


func add_motivation_points(amount: int) -> void:
	motivation_points = motivation_points + amount


func subtract_motivation_points(amount: int) -> void:
	motivation_points = motivation_points - amount
