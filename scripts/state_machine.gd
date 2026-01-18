# state_machine.gd - State machine controller
class_name StateMachine
extends Node

var current_state: State
var states: Dictionary = {}

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.state_machine = self
	
	# Wait one frame for player to set references
	await get_tree().process_frame
	
	if states.has("idle"):
		current_state = states["idle"]
		current_state.enter()

func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)

func _unhandled_input(event: InputEvent) -> void:
	if current_state:
		current_state.handle_input(event)

func transition_to(target_state_name: String) -> void:
	var target_state = states.get(target_state_name.to_lower())
	if not target_state or target_state == current_state:
		return
	
	if current_state:
		current_state.exit()
	
	current_state = target_state
	current_state.enter()
	print("Transitioned to: ", target_state_name)
