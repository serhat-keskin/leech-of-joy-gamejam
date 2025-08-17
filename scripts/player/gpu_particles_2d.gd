extends GPUParticles2D

@onready var harvest_hitbox = $"../Area2D"
@onready var player = $"../.."

func _process(delta: float) -> void:
	if self.emitting:
		var bodies = harvest_hitbox.get_overlapping_bodies()
		
		for _body in bodies:
			var body: Node2D = _body
			if body.is_in_group("enemy"):
				self.global_position = body.global_position

				var vector_from_enemy = player.global_position - body.global_position
				var vector = vector_from_enemy.normalized()
			
				var material = self.process_material as ParticleProcessMaterial
				material.gravity = Vector3(vector.x * 500, vector.y * 500, 0)
				
				material.initial_velocity_min = 100
				material.initial_velocity_max = 200
