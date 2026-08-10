extends Node2D

@export var upper_floor_unlocked: bool = true
@export var lower_floor_unlocked: bool = true

var player_in_upper_floor: bool = false
var player_in_lower_floor: bool = false


func _physics_process(_delta: float) -> void:
	if $TopFloorDetector.has_overlapping_bodies() and not player_in_upper_floor:
		player_in_upper_floor = true
		reveal_top_floor()
	elif not $TopFloorDetector.has_overlapping_bodies() and player_in_upper_floor:
		player_in_upper_floor = false
		hide_top_floor()
	
	if $BottomFloorDetector.has_overlapping_bodies() and not player_in_lower_floor:
		player_in_lower_floor = true
		reveal_bottom_floor()
	elif not $BottomFloorDetector.has_overlapping_bodies() and player_in_lower_floor:
		player_in_lower_floor = false
		hide_bottom_floor()


func reveal_top_floor() -> void:
	$HouseFrameTopLayer.show()
	
	var opacity_tween = $TopCover.create_tween()
	opacity_tween.tween_property($TopCover, "modulate", Color(1.0, 1.0, 1.0, 0.0), 0.3)


func hide_top_floor() -> void:
	$HouseFrameTopLayer.hide()
	
	var opacity_tween = $TopCover.create_tween()
	opacity_tween.tween_property($TopCover, "modulate", Color(1.0, 1.0, 1.0, 1.0), 0.3)


func reveal_bottom_floor() -> void:
	var opacity_tween = $BottomCover.create_tween()
	opacity_tween.tween_property($BottomCover, "modulate", Color(1.0, 1.0, 1.0, 0.0), 0.3)


func hide_bottom_floor() -> void:
	var opacity_tween = $BottomCover.create_tween()
	opacity_tween.tween_property($BottomCover, "modulate", Color(1.0, 1.0, 1.0, 1.0), 0.3)
