extends Node2D


@export var mute: bool = false
@export var hammer_cracking_incremental_sounds: Array[AudioStream] = []
@export var nut_cracking_on_rock_incremental_sounds: Array[AudioStream] = []
@export var demolition_crane_sounds: Array[AudioStream] = []

var current_track = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	process_mode = Node.PROCESS_MODE_ALWAYS
	#$Music.finished.connect(on_music_finished)

# If we decide to add menu music, uncomment these methods and make the $MenuMusic node
#func play_menu_music() -> void:
	#if not mute: $MenuMusic.play()
#
#func stop_menu_music() -> void:
	#if not mute: $MenuMusic.stop()

#func play_in_game_music() -> void:
	##if mute or music_tracks.is_empty(): return
	##$Music.stream = music_tracks[current_track]
	#$Music.play()
#
#func on_music_finished() -> void:
	##current_track = (current_track + 1) % len(music_tracks)
	#play_in_game_music()

func play_crow_caw() -> void:
	if not mute: $CrowCaw.play()

func play_hammer_cracking_nut_sound(index: int = 0) -> void:
	if mute or hammer_cracking_incremental_sounds.is_empty(): return
	$HammerCrackingNut.stream = hammer_cracking_incremental_sounds[index % len(hammer_cracking_incremental_sounds)]
	$HammerCrackingNut.play()

func play_item_dropped_on_grass_sound() -> void:
	if not mute: $ItemDroppedOnGrass.play()

func play_item_dropped_on_generic_surface_sound() -> void:
	if not mute: $ItemDroppedGenericSurface.play()

func play_keypad_interaction_sound() -> void:
	if not mute: $KeypadInteraction.play()

func play_man_accept_nut_sound() -> void:
	if not mute: $ManAcceptingNut.play()

func play_man_decline_nut_sound() -> void:
	if not mute: $ManDecliningNut.play()

func play_nut_cracking_on_rock_sound(index: int = 0) -> void:
	if mute or nut_cracking_on_rock_incremental_sounds.is_empty(): return
	$NutCrackingOnRock.stream = nut_cracking_on_rock_incremental_sounds[index % len(nut_cracking_on_rock_incremental_sounds)]
	$NutCrackingOnRock.play()

func play_nut_on_rock_sound() -> void:
	if not mute: $NutOnRock.play()

func play_wing_flap_sound() -> void:
	if not mute: $WingFlap.play()

func play_hydraulic_press_running_sound() -> void:
	if not mute: $HydraulicPress.play()

func play_nut_statue_demolish_sound() -> void:
	if not mute: $NutStatue.play()

func play_safe_box_break_sound(_index: int = 0) -> void:
	if not mute: $SafeBox.play()

func play_demolition_crane_sound() -> void:
	$DemolitionCrane.stream = demolition_crane_sounds[0] # startup
	if not mute: $DemolitionCrane.play()
	await get_tree().create_timer(2).timeout
	_on_demolition_crane_finished()

func play_demolition_crane_loop() -> void:
	if not mute: $DemolitionCrane.play()

# On Loop Finished
func _on_demolition_crane_finished() -> void:
	if not mute: $DemolitionCrane.play()
