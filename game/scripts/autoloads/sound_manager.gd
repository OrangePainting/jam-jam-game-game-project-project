extends Node2D


@export var mute: bool = false

var current_track = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	process_mode = Node.PROCESS_MODE_ALWAYS
	$Music.finished.connect(on_music_finished)

# If we decide to add menu music, uncomment these functions and make the $MenuMusic node
#func play_menu_music() -> void:
	#if not mute: $MenuMusic.play()
#
#func stop_menu_music() -> void:
	#if not mute: $MenuMusic.stop()

func play_in_game_music() -> void:
	#if mute or music_tracks.is_empty(): return
	#$Music.stream = music_tracks[current_track]
	$Music.play()

func on_music_finished() -> void:
	#current_track = (current_track + 1) % len(music_tracks)
	play_in_game_music()

func play_click() -> void:
	if not mute: $Click.play()
