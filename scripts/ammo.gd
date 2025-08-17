extends CharacterBody2D

var despawntime=5
var dir
@export var speed = 200
func _ready() -> void:
	print("speed:", speed, " dir:", dir, " velocity:", velocity)
	despawn()

func _physics_process(delta: float) -> void:
	velocity.x = speed * dir
	move_and_slide()
	
	
func despawn():
	await get_tree().create_timer(despawntime).timeout
	queue_free()
	





func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_node("HealthComponent") and body.is_in_group("player"):
		print("player take damage")
		var health = body.get_node("HealthComponent")
		health.take_damage(1, 10)
		queue_free()
		
			
