extends Node2D

var has_exploded = false
@onready var aoe_hitbox = $Area2D
@onready var damage_timer = $"../DamageTimer"

func throw(velocity: Vector2):
	print("Fart bag throw called with velocity: ", velocity)
	$RigidBody2D.linear_velocity = velocity
	print("RigidBody2D linear_velocity set to: ", $RigidBody2D.linear_velocity)

func explode():
	if has_exploded:
		return
	$GPUParticles2D.emitting = true
	has_exploded = true
	print("Explode called!")
	$Icon.visible = false;
	$AoETimer.start()
	damage_timer.start()
	print("AoE timer started, wait_time: ", $AoETimer.wait_time)
	
	
func _on_rigid_body_2d_body_entered(body: Node) -> void:
	if (body.is_in_group("Enemy")):
		explode();

func _on_ao_e_timer_timeout() -> void:
	print("aoe timeout destroying")
	get_parent().remove_child(self)
	queue_free()
	

func _on_explosion_timer_timeout() -> void:
	explode()


func _on_body_entered(body: Node) -> void:
	$ExplosionTimer.start()
	print("contacted ground")
	
	
func _on_damage_timer_timeout() -> void:
	var bodies = aoe_hitbox.get_overlapping_bodies()
	for _body in bodies:
		var body: Node2D = _body;
		
		if body.has_node("HealthComponent") and body.is_in_group("enemy"):
			var health = body.get_node("HealthComponent")
			health.take_damage(1, 0)
			print("aoe damage")
