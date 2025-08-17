extends Node2D

@onready var boss_idle: Node2D = $"../BossIdle"
@onready var prefab_scene: PackedScene = preload("res://prefabs/enemy_boss.tscn")  # ← prefab path
@onready var level_music = preload("res://assets/musics/background musics/Boss music.wav")

const lines: Array = [
	["ENOUGH!"], 
	["It seems the BIG guy decided to show up."],
	["You were boring yourself with your own voice."],
	["Two words you big fart baloon. Hard work"],
	["Sure, then this ”fart balloon” is gonna make you suffocate."],
	["Sure, come on then."],
	["*BIG BOI SCREAMING*"]
]

var is_player_inside = false
var player: Node = null
var dialogue_started = false

func _ready():
	self.body_entered.connect(_on_body_entered)
	self.body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body.name == "Player" and not dialogue_started:
		is_player_inside = true
		player = body
		dialogue_started = true
		# Player hareketini durdur
		player.set_process(false)
		player.set_physics_process(false)
		await _start_dialogue_sequence()  # ✅ await burada kullanılacak

func _on_body_exited(body):
	if body.name == "Player":
		is_player_inside = false

# Godot 4 async
func _start_dialogue_sequence() -> void:
	for i in lines.size():
		var target = boss_idle.global_position if i % 2 == 0 else player.global_position
		var dialog = DialogueManager.start_dialog(target, lines[i])
		await dialog.dialog_finished  # signal bekleniyor

	# Diyalog tamamlandı, player aktif olsun
	if player:
		player.set_process(true)
		player.set_physics_process(true)

	# Prefab instantiate et
	var instance = prefab_scene.instantiate()
	get_parent().add_child(instance)  # parent node’a ekle
	instance.global_position = boss_idle.global_position  # örnek pozisyon

	# Boss_idle objesini sahneden sil
	if boss_idle:
		boss_idle.queue_free()
		
	AudioManager.play_music(level_music)
