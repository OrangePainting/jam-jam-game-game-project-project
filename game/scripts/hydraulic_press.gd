extends StaticBody2D



@onready var crushing_area: Area2D = %CrushingArea

@export var object_to_crush: String = ""

func start_hydraulic_press():
	$AnimationPlayer.play("crush")
	AudioController.play_hydraulic_press_running_sound()

func crush_objects():
	var objects_in_range := crushing_area.get_overlapping_areas()
	for obj in objects_in_range:
		var node := obj.get_node("..")
		if node and node is BreakableInteractable and node.name == object_to_crush:
			node._break_open()

func _on_hydraulic_press_controls_interacted_with(_interactor: Node2D) -> void:
	start_hydraulic_press()

# Happens once the animation is done
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "crush":
		$AnimationPlayer.play("RESET")
		crush_objects()
