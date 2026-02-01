extends Node

#this is the manager that changes the state of character

var character
var current_state: State
var attack_action:String = "Null"

func init(_character):
	character = _character
	
	for state in get_children():
		state.character = _character
		state.state_machine = self
		
	current_state = get_child(0)
	current_state.enter()

# Called when the node enters the scene tree for the first time.

func change_state(state_name:String):
	current_state.exit()
	current_state = get_node(state_name)
	current_state.enter()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	current_state.update(delta)
