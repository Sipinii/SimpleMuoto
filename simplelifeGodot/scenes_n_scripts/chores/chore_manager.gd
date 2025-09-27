class_name ChoreManger
extends Node

@export var chores: Array[ChoreBase]
@export var muoto: Muoto


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var lowest_cost_chore: ChoreBase = chore_with_lowest_m_cost()
	if lowest_cost_chore != null:
		muoto.buy_chore_with_motivation_if_possible(lowest_cost_chore)
	pass


func chore_with_lowest_m_cost() -> ChoreBase:
	if chores.is_empty():
		return null
	var lowest := chores[0]
	for chore in chores:
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
