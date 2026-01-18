# wall_slide_state.gd
class_name WallSlideState
extends State

var wall_buffer_time = 0.1  # Stay on wall for 0.1s even if contact is lost
var wall_timer = 0.0

func enter() -> void:
	player.wall_slide_effect.emitting = true
	var wall_dir = -player.get_wall_normal().x
	player.wall_slide_effect.direction = Vector2(wall_dir * 200, 0)
	wall_timer = wall_buffer_time

func exit() -> void:
	player.wall_slide_effect.emitting = false

func physics_update(delta: float) -> void:
	player.apply_gravity(delta)
	
	var direction = player.get_input_direction()
	player.velocity.y = min(player.velocity.y, player.WALL_SLIDE_SPEED)
	# Removed the velocity.x += JUMP_VELOCITY line!
	
	# Update wall timer
	if player.is_on_wall():
		wall_timer = wall_buffer_time  # Reset timer while touching wall
	else:
		wall_timer -= delta
	
	# Transitions
	if player.is_on_floor():
		state_machine.transition_to("Idle")
	elif Input.is_action_just_pressed("ui_accept"):
		state_machine.transition_to("WallJump")
	elif wall_timer <= 0 or direction == 0:  # Only fall if timer runs out or no input
		state_machine.transition_to("Fall")
