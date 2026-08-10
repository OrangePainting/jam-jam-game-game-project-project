extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioController.play_in_game_music()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_crane_end_game() -> void:
	AudioController.stop_main_music()
	$Bird.hide()
	$Bird.process_mode = Node.PROCESS_MODE_DISABLED
	$Crane/AnimationPlayer.play("start_moving")
	var camera = $Bird/Camera2D
	camera.reparent(self)
	var pan_camera = camera.create_tween()
	pan_camera.tween_property(camera, "position", Vector2(camera.position.x - 1580, camera.position.y), 3.0)
	var fade_out = $UI/ColorRect.create_tween()
	fade_out.tween_property($UI/ColorRect, "color", Color(0.0, 0.0, 0.0, 1.0), 5.0)
	await get_tree().create_timer(2.0).timeout
	AudioController.play_nut_statue_demolish_sound()
	await get_tree().create_timer(4.0).timeout
	AudioController.play_crow_eat(true)
	await get_tree().create_timer(2.0).timeout
	
	print("game won")
