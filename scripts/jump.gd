# jump_state.gd
class_name JumpState
extends State

func enter() -> void:
	# Always jump when entering this state - the check happens before transitioning
	player.velocity.y = player.JUMP_VELOCITY
	player.jumps -= 1

func physics_update(delta: float) -> void:
	player.apply_gravity(delta)
	
	var direction = player.get_input_direction()
	if direction:
		player.velocity.x = direction * player.SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.SPEED * 0.5)
	
	# Transitions - CHECK DOUBLE JUMP FIRST!
	if Input.is_action_just_pressed("ui_accept") and player.jumps > 0:
		state_machine.transition_to("Jump")  # Re-enter for double jump
	elif player.velocity.y >= 0:
		state_machine.transition_to("Fall")
	elif player.has_dash and Input.is_action_just_pressed("dash_key"):
		state_machine.transition_to("Dash")
	elif player.has_wall_jump and player.is_on_wall() and direction != 0:
		state_machine.transition_to("WallSlide")
