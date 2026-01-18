class_name IdleState
extends State

func enter() -> void:
	player.velocity.x = 0

func physics_update(delta: float) -> void:
	player.apply_gravity(delta)
	player.reset_jumps()
	
	var direction = player.get_input_direction()
	
	# Transitions
	if not player.is_on_floor():
		state_machine.transition_to("Fall")
	elif Input.is_action_just_pressed("ui_accept"):
		state_machine.transition_to("Jump")
	elif direction != 0:
		state_machine.transition_to("Run")
	elif player.has_dash and Input.is_action_just_pressed("dash_key"):
		state_machine.transition_to("Dash")
