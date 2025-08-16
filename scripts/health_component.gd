extends Node


@export var max_health = 10
@export var time_till_harvest = 0.5

@onready var health = max_health
var ran_out_of_health = false
var dead = false

signal on_ran_out_of_health
signal on_damage(damage: float, knockback: float)
signal on_death

func take_damage(damage: float, knockback: float):
	on_damage.emit(damage, knockback)
	
	var next_health = health - damage
	if next_health <= 0:
		health = max(0, next_health)
		on_ran_out_of_health.emit()
		ran_out_of_health = true
	else:
		health = next_health
		
func harvest(delta: float):
	time_till_harvest -= delta
	if time_till_harvest < 0:
		on_death.emit()

func try_harvest(delta: float) -> bool:
	if ran_out_of_health:
		harvest(delta)
		return true
	else:
		return false

func _on_dead() -> void:
	ran_out_of_health = true
	
