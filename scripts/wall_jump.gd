
class_name WallJumpState
extends State

func enter() -> void:
	var wall_dir = player.get_wall_normal().x
	player.velocity.y = player.WALL_JUMP_FORCE_Y
	player.velocity.x = wall_dir * player.WALL_JUMP_FORCE_X

func physics_update(delta: float) -> void:
	player.apply_gravity(delta)
	
	# Allow slight air control
	var direction = player.get_input_direction()
	if direction:
		player.velocity.x = move_toward(player.velocity.x, direction * player.SPEED, player.SPEED * 0.3)
	
	# Transitions
	if player.velocity.y >= 0:
		state_machine.transition_to("Fall")
	elif player.is_on_floor():
		state_machine.transition_to("Idle")
	elif player.has_dash and Input.is_action_just_pressed("dash_key"):
		state_machine.transition_to("Dash")
