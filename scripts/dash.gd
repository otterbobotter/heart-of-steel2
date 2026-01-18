class_name DashState
extends State

var dash_timer: float = 0.0
var dash_direction: float = 0.0

func enter() -> void:
	player.is_dashing = true
	player.dash_effect.emitting = true
	dash_timer = player.DASH_DURATION
	dash_direction = player.get_input_direction()
	if dash_direction == 0:
		dash_direction = 1  # Default to right if no input
	
	player.velocity.x = dash_direction * player.DASH_SPEED
	player.velocity.y = 0

func exit() -> void:
	player.is_dashing = false
	player.dash_effect.emitting = false

func physics_update(delta: float) -> void:
	dash_timer -= delta
	
	if dash_timer <= 0:
		if player.is_on_floor():
			state_machine.transition_to("Idle")
		else:
			state_machine.transition_to("Fall")
