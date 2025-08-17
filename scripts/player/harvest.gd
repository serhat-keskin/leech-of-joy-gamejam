extends Node2D

@onready var hitbox = $Area2D
var is_harvesting = false
var max_power = 2
@export var power = 1
var always_play_particles = false

func _process(delta: float) -> void:
	var bodies = hitbox.get_overlapping_bodies()
	
	var bodyies_with_health_components_count = 0
	for _body in bodies:
		var body: Node2D = _body
		if body.has_node("HealthComponent") and body.is_in_group("enemy"):
			var health = body.get_node("HealthComponent")
			bodyies_with_health_components_count += 1
			is_harvesting = health.try_harvest(delta)
			
	
	if bodyies_with_health_components_count == 0:
		is_harvesting = false

	
	
	if is_harvesting:
		$GPUParticles2D.emitting = true
		if power < max_power:
			power += delta
	else: 
		$GPUParticles2D.emitting = false
	
	$"../CanvasLayer/ProgressBar".value = power
	$"../CanvasLayer/HealthBar".value = $"../HealthComponent".health

func _ready() -> void:
	$"../CanvasLayer/ProgressBar".max_value = max_power
	
	$"../CanvasLayer/HealthBar".max_value = $"../HealthComponent".max_health
	
	
