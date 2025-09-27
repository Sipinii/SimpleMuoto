class_name ClickableArea
extends Area2D
## USAGE: Attach this Node to a parent Sprite2D. Mimics the behavior of a UI button.

signal clicked
signal mouse_entered_area
signal mouse_exited_area

## If set to true, creates a collider matching the sprite of the parent in _ready().
## Otherwise needs a collision shape to work.
@export var create_polygon_collider = false
## Draws a line showing the created polygon collider shape if one was created.
@export var draw_poly = false
# The smaller the epsilon, more detailed the collision shape.
var epsilon : int = 2
var polys = []
var collision_polygon: CollisionPolygon2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if create_polygon_collider:
		sprite_to_polygon()
	pass # Replace with function body.


# TODO: This seems to be enough for clicks to register when this node has a collision
# node as a child. Yet, it doesn't really have any reference to mouse position.
# Figure out how it works.
func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("click_primary"):
		#print("Button clicked.")
		emit_signal("clicked")


func _mouse_enter() -> void:
	#print("Mouse entered clickable area.")
	emit_signal("mouse_entered_area")


func _mouse_exit() -> void:
	#print("Mouse exited clickable area.")
	emit_signal("mouse_exited_area")


func _draw() -> void:
	if create_polygon_collider and draw_poly:
		for i in range(1, len(collision_polygon.polygon)):
			draw_line(collision_polygon.polygon[i] + collision_polygon.position,
					collision_polygon.polygon[i-1] + collision_polygon.position,
					Color.RED, 0.5, true)


# NOTE: Top only object picking is set on in game_manager.gd
# Used this tutorial: https://youtu.be/zeYtjYPjCkg?si=WW9McFXk_lAhndPm
func sprite_to_polygon():
	var bitmap = BitMap.new()
	bitmap.create_from_image_alpha(get_parent().get_texture().get_image())
	polys = bitmap.opaque_to_polygons(Rect2(Vector2.ZERO, get_parent().get_texture().get_size()),
			 epsilon)
	for poly in polys:
		collision_polygon = CollisionPolygon2D.new()
		collision_polygon.polygon = poly
		add_child(collision_polygon)
		if get_parent().centered:
			collision_polygon.position -= Vector2(bitmap.get_size() / 2)
			collision_polygon.position += get_parent().offset
