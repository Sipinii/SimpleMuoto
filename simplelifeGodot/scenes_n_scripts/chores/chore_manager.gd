class_name ChoreManager
extends Node

@export var chores: Array[ChoreBase]
@export var muoto: Muoto


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


## NOTE: Only takes into account Chores that can currently be bought.
func chore_with_lowest_m_cost() -> ChoreBase:
	if chores.is_empty():
		return null
	var lowest: ChoreBase = null
	for chore in chores:
		var current_state = chore.state_machine.current_state()
		if current_state is ChoreStateCostDecreasing:
			if lowest == null:
				lowest = chore
			elif chore.current_motivation_cost < lowest.current_motivation_cost:
				lowest = chore
	return lowest


# TODO:
func add_chore(chore: ChoreBase) -> void:
	if not chores.has(chore):
		chores.append(chore)


# TODO:
func remove_chore(chore: ChoreBase) -> void:
	chores.erase(chore)
