extends Node

@onready var player = $".."
@onready var attack_hitbox = $"../Attack/Area2D"
@onready var attack_nodes = $"../Attack"
enum MovementState {
	JUMPING,
	FALLING,
	ON_GROUND
};

enum CharFacing {
	LEFT,
	RIGHT,
}


@export var jump_accelaration: Curve
@export var fall_acceleration: Curve
@export var run_acceleration: Curve
@export var dash_acceleration: Curve
@export var dash_air_acceleration: Curve
@export var on_air_aceeleration_mult: float = 0.7


@export var jump_velocity: float = -350.0
@export var fall_gravity_multiplier: float = 1.5
@export var jump_cut_multiplier: float = 2.0
@export var jump_buffer_time: float = 0.1
@export var coyote_time: float = 0.15

var facing: CharFacing = CharFacing.LEFT
@export var dash_cooldown: float = 0.5

var time_since_last_jump: float = 0
var time_since_on_ground: float = 0
var time_since_last_direction_input: float = 0
var time_since_last_jump_input: float = 100.0
var time_since_dash: float = 1000

var was_dash_on_ground: bool = false

@export var is_dashing = false

@export var state: MovementState = MovementState.FALLING;
var dash_velocity: float = 0
var dash_air_extra_velocity: float = 0
var knockback_velocity: float = 0 # For knockback from damage


var buffering_jump: bool = false
var coyote_timer = 0.0
var dash_timer = dash_cooldown


func _physics_process(delta):
	# Update timers
	coyote_timer -= delta
	dash_timer -= delta
	time_since_last_jump += delta
	time_since_on_ground += delta
	time_since_last_direction_input += delta
	time_since_last_jump_input += delta
	time_since_dash += delta

	if player.is_on_floor():
		coyote_timer = coyote_time
		state = MovementState.ON_GROUND
		time_since_on_ground = 0
	else:
		if state == MovementState.ON_GROUND:
			state = MovementState.FALLING

	# Apply Gravity
	if not player.is_on_floor():
		var current_gravity = player.get_gravity()
		if player.velocity.y > 0: # Falling
			player.velocity += current_gravity * fall_gravity_multiplier * delta
		elif not Input.is_action_pressed("jump"): # Jump cut
			player.velocity += current_gravity * jump_cut_multiplier * delta
		else:
			player.velocity += current_gravity * delta

	# Jump Input Handling
	if Input.is_action_just_pressed("jump"):
		time_since_last_jump_input = 0
		buffering_jump = true

	# Perform Jump
	if buffering_jump and time_since_last_jump_input <= jump_buffer_time:
		if coyote_timer > 0:
			player.velocity.y = jump_velocity
			state = MovementState.JUMPING
			time_since_last_jump = 0
			coyote_timer = 0
			buffering_jump = false

	if player.is_on_floor():
		# Consume jump buffer when landing
		if buffering_jump and time_since_last_jump_input <= jump_buffer_time:
			player.velocity.y = jump_velocity
			state = MovementState.JUMPING
			time_since_last_jump = 0
			coyote_timer = 0
			buffering_jump = false
		else:
			# If we are on floor and not jumping, reset Y velocity if needed 
			# (move_and_slide handles most of this)
			pass

	if Input.is_action_just_pressed("dash") and dash_timer <= 0:
		time_since_dash = 0
		dash_timer = dash_cooldown
		if player.is_on_floor():
			was_dash_on_ground = true
		else:
			was_dash_on_ground = false

	var zero_point_dash = dash_acceleration.get_point_position(dash_acceleration.point_count - 1).x;
	var zero_point_dash_extra = dash_air_acceleration.get_point_position(dash_air_acceleration.point_count - 1).x;

	var max_dash_len = max(zero_point_dash, zero_point_dash_extra);

	if time_since_dash < max_dash_len:
		is_dashing = true
		
		if facing == CharFacing.RIGHT:
			dash_velocity = dash_acceleration.sample(time_since_dash);
			
			if state == MovementState.JUMPING and was_dash_on_ground:
				dash_air_extra_velocity = dash_air_acceleration.sample(time_since_dash)
				#print(dash_air_acceleration.sample(time_since_dash))
		
		elif facing == CharFacing.LEFT:
			dash_velocity = - dash_acceleration.sample(time_since_dash)
			
			if state == MovementState.JUMPING and was_dash_on_ground:
				dash_air_extra_velocity = - dash_air_acceleration.sample(time_since_dash)
				#print(-dash_air_acceleration.sample(time_since_dash))
	else:
		dash_air_extra_velocity = 0;
		dash_velocity = 0;
		is_dashing = false
	

	if Input.is_action_just_pressed("right") or Input.is_action_just_pressed("left"):
		time_since_last_direction_input = 0

	var direction := Input.get_axis("left", "right")

	var effective_direction = direction
	if !player.is_on_floor():
		effective_direction *= on_air_aceeleration_mult

	if direction:
		if abs(dash_velocity) > 0.01:
			effective_direction *= 0.2;

		player.velocity.x = effective_direction * run_acceleration.sample(time_since_last_direction_input) + dash_velocity + dash_air_extra_velocity + knockback_velocity
		
		if abs(dash_velocity) <= 0.01:
			if direction > 0:
				facing = CharFacing.RIGHT;
			elif direction < 0:
				facing = CharFacing.LEFT;
	else:
		player.velocity.x = dash_velocity + dash_air_extra_velocity + knockback_velocity
	
	if DialogueManager.is_dialog_active:
		player.velocity = Vector2.ZERO
	
	player.move_and_slide()


func _process(delta: float) -> void:
	# flip the sprite on rotation
	if player.velocity.x > 0:
		owner.sprite.flip_h = false
		attack_nodes.scale.x = 1
	elif player.velocity.x < 0:
		owner.sprite.flip_h = true
		attack_nodes.scale.x = -1
