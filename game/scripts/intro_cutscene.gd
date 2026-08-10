extends Control


@onready var label = %Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton or (event is InputEventKey and event.pressed):
		get_tree().change_scene_to_file("res://game/scenes/main.tscn")
