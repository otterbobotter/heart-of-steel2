# fall_state.gd
class_name FallState
extends State

func physics_update(delta: float) -> void:
	player.apply_gravity(delta)
	
	var direction = player.get_input_direction()
	if direction:
		player.velocity.x = direction * player.SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.SPEED * 0.5)
	
	# Transitions
	if player.is_on_floor():
		state_machine.transition_to("Idle")
	elif Input.is_action_just_pressed("ui_accept") and player.jumps > 0:
		state_machine.transition_to("Jump")  # This already exists!
	elif player.has_dash and Input.is_action_just_pressed("dash_key"):
		state_machine.transition_to("Dash")
	elif player.has_wall_jump and player.is_on_wall() and direction != 0:
		state_machine.transition_to("WallSlide")
