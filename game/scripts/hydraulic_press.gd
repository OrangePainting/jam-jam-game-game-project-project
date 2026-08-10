extends StaticBody2D



@onready var crushing_area: Area2D = %CrushingArea

@export var object_to_crush: String = ""

var is_running: bool = false

func _ready() -> void:
	crushing_area.get_child(0).disabled = true

func start_hydraulic_press():
	if not is_running:
		is_running = true
		$AnimationPlayer.play("crush")
		AudioController.play_hydraulic_press_running_sound()
		crushing_area.get_child(0).disabled = false
		await $AnimationPlayer.animation_finished
		is_running = false

func _on_hydraulic_press_controls_interacted_with(_interactor: Node2D) -> void:
	start_hydraulic_press()

# Happens once the animation is done
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "crush":
		$AnimationPlayer.play("RESET")
		crushing_area.get_child(0).disabled = true
		#crush_objects()

func _on_crushing_area_body_entered(body: Node2D) -> void:
	if body.name.match(object_to_crush) and body is BreakableInteractable:
		body._break_open()
