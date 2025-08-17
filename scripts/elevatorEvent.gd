extends Node2D

@export var next_level_name: String = "Level1"

var isPlayerInside = false
var isPlayerWaitingElevetorToBeOpened = false
var player = null

func _ready():
	$Area2D.body_entered.connect(_on_body_entered)
	$Area2D.body_exited.connect(_on_body_exited)

func _input(event):
	if event.is_action_pressed("interact") and isPlayerInside:
		$AnimationPlayer.play("open")
		isPlayerWaitingElevetorToBeOpened = true
		if player:
			player.process_mode = Node.PROCESS_MODE_DISABLED

func _on_body_entered(body):
	if body.name == "Player":
		isPlayerInside = true
		player = body
		
func _on_body_exited(body):
	if body.name == "Player":
		isPlayerInside = false

func _process(delta: float) -> void:
	if isPlayerWaitingElevetorToBeOpened and not $AnimationPlayer.is_playing():
		if next_level_name != "":
			var next_scene_path = "res://GameSystem/%s.tscn" % next_level_name
			var next_scene = load(next_scene_path)
			if next_scene:
				get_tree().change_scene_to_packed(next_scene)

		
