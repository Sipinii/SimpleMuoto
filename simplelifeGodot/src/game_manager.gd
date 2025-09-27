extends Node
## Controls the highest level functionality of the game such as initializing/quitting
## the application or changing between (highest level) game modes.


func _ready() -> void:
	# Turn on top-only object picking for 2D canvas items:
	get_viewport().set_physics_object_picking_sort(true)
	get_viewport().set_physics_object_picking_first_only(true)
