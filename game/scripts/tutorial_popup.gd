extends Control

## How high this popup floats when added to the scene.
@export var float_up_height: float = 20.0
## How many seconds this popup stays on screen before fading away
@export var stay_duration: float = 10.0

func _ready() -> void:
	var position_tween = self.create_tween()
	var fade_in_tween = self.create_tween()
	modulate = Color(1.0, 1.0, 1.0, 0.0)
	
	position_tween.tween_property(self, "position", Vector2(position.x, position.y - float_up_height), 0.5)
	fade_in_tween.tween_property(self, "modulate", Color(1, 1, 1, 1), 0.5)
	
	await get_tree().create_timer(stay_duration).timeout
	
	var fade_out_tween = self.create_tween()
	fade_out_tween.tween_property(self, "modulate", Color(1.0, 1.0, 1.0, 0.0), 1.0)
	await fade_out_tween.finished
	queue_free()
