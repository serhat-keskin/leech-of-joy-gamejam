extends Node
class_name StateMachine

var current_state: Node = null
var previous_state: Node = null
var states := {}

func initialize(states_node: Node) -> void:
	states.clear()
	for child in states_node.get_children():
		if child is Node:
			states[child.name] = child
	# İlk state: States altındaki ilk node
	if states_node.get_child_count() > 0:
		change_state(states_node.get_child(0).name)

func change_state(state_name: String) -> void:
	if not states.has(state_name):
		push_error("State '%s' not found!" % state_name)
		return

	if current_state and current_state.has_method("exit"):
		current_state.exit(get_parent())

	previous_state = current_state
	current_state = states[state_name]
	
	if current_state and current_state.has_method("enter"):
		#print("entering state", current_state)
		current_state.enter(get_parent())
