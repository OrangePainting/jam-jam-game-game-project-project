class_name Interactable extends RigidBody2D

@export var can_interact: bool = true

@onready var zone_detector: Area2D = %ZoneDetection

# Linear velocity is already built into RigidBody2D, so we can just use
#   linear_velocity = Vector2.ONE 
# for example

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	contact_monitor = true
	max_contacts_reported = 4


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node) -> void:
	push_error("Interactable._on_body_entered() not implemented in %s. Define it!" % name)



func _on_zone_entered(area: Area2D) -> void:
	push_error("Interactable._on_zone_entered() not implemented in %s. Define it!" % name)
