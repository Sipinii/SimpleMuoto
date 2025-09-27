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
	var lowest := chores[0]
	for chore in chores:
		if chore.current_state == ChoreBase.ChoreState.COST_DECREASING:
			if chore.current_motivation_cost < lowest.current_motivation_cost:
				lowest = chore
	return lowest


# TODO:
func add_chore(chore: ChoreBase) -> void:
	if not chores.has(chore):
		chores.append(chore)
	pass


# TODO:
func remove_chore(chore: ChoreBase) -> void:
	chores.erase(chore)
	pass
