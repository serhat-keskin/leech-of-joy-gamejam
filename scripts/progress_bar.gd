extends Node2D


@onready var progress_bar := $ProgressBar as ProgressBar
var health # Don't use @onready with parent paths
@export var knockback_curve: Curve
var knockback_timer = 0
var knockback_val = 0

func _ready() -> void:
	# Wait a frame to ensure parent is fully ready
	await get_tree().process_frame
	
	# Now get theac HealthComponent
	health = get_parent().get_node_or_null("HealthComponent")
	
	if health != null:
		progress_bar.max_value = health.max_health
		progress_bar.value = 0 # Start at 0 (no damage taken yet)
	else:
		push_error("HealthComponent not found!")
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		pass
		
func set_health_bar() -> void:
	# Bar fills up as health decreases
	var calculated_value = health.max_health - health.health
	progress_bar.value = calculated_value
	
	
func _on_health_component_on_damage(damage: float, knockback: float) -> void:
	knockback_timer = 0
	knockback_val = knockback
	
	#wtf first hit doesnt work unless this is here
	await get_tree().process_frame
	set_health_bar()



func _process(delta: float) -> void:
	knockback_timer += delta
	
	if knockback_curve:	
		$"..".velocity.x = knockback_curve.sample(knockback_timer) * knockback_val




func _on_health_component_on_death() -> void:
	$"..".queue_free()
