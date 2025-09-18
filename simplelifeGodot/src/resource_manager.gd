# Used to save player's resources.
extends Node

# NOTE: NEVER ACCESS THESE DIRECTLY! USE GET/SET METHODS (OR SIMILAR) INSTEAD!
# TODO: Save all relevant info here e.g. chores and their stats.
# TODO: Use this together with the save system (load resources based on save file).
var motivation_points: int = 0
#var growthPoints: int = 0
#var pennies: int = 0

func add_motivation_points(amount: int) -> void:
	motivation_points += amount
	print("Added " + str(amount) + " motivation points. Motivation is now: " + str(motivation_points))
	pass
