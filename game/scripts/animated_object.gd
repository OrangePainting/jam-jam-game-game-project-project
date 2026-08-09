extends Node2D

## Generic class to cause animations to play when signals are triggered.
## Connect via the signal editor to _on_trigger

func play_animation() -> void:
	$AnimationPlayer.play("test_anim")

## External function for receiving signals
func _on_trigger(_dummy: Node2D) -> void:
	play_animation()

## External function for receiving signals
func _on_placed(_a, _b) -> void:
	play_animation()
