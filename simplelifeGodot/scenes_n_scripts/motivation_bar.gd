extends Node

@onready var bar_down: Sprite2D = $MotivationBarDown
@onready var bar_up: Sprite2D = $MotivationBarUp
@onready var star_button_down: Sprite2D = $StarButtonDown
@onready var star_button_up: Sprite2D = $StarButtonUp

var sprites: Array 


func _ready() -> void:
	sprites = [bar_down, bar_up, star_button_down, star_button_up]
	InputManager.primary_click_released.connect(_on_primary_click_released)
	pass


func _on_star_button_clicked() -> void:
	star_button_up.visible = false
	#var mat = bar_up.material as ShaderMaterial
	#mat.set_shader_parameter("flash_value", 0.0)
	ResourceManager.add_motivation_points(1)
	pass # Replace with function body.


func _on_motivation_bar_clicked() -> void:
	bar_up.visible = false
	star_button_up.visible = false
	#var mat = bar_up.material as ShaderMaterial
	#mat.set_shader_parameter("flash_value", 0.0)
	ResourceManager.add_motivation_points(1)
	pass # Replace with function body.


func _on_primary_click_released() -> void:
	bar_up.visible = true
	star_button_up.visible = true
	star_button_down.visible = true
	pass


func _on_motivation_bar_mouse_entered() -> void:
	#var mat = bar_up.material as ShaderMaterial
	#mat.set_shader_parameter("flash_value", 0.3)
	pass # Replace with function body.


func _on_motivation_bar_mouse_exited() -> void:
	#var mat = bar_up.material as ShaderMaterial
	#mat.set_shader_parameter("flash_value", 0.0)
	pass # Replace with function body.
