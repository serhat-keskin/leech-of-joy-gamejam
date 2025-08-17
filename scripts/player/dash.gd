extends Node
@onready var player_movement = $"../PlayerMovement"

var dash_effect_timer = 0;
var dash_effct_time = 0.2

	
func _process(delta: float) -> void:
	if player_movement.is_dashing:
		self.emitting = true
	else:
		self.emitting = false
		
	
	if player_movement.facing == 0:
		self.material.set_shader_parameter("flip_h", true)
	else:
		self.material.set_shader_parameter("flip_h", false)
		pass
	
