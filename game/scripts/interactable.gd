class_name Interactable extends RigidBody2D

@export var can_interact: bool = true

@export var carry_offset := Vector2(-50, 0)

@onready var zone_detector: Area2D = %ZoneDetection
@onready var collision_detector: CollisionShape2D = %InteractionDetection

var is_held: bool = false
var held_by: Node2D = null

# Linear velocity is already built into RigidBody2D, so we can just use
#   linear_velocity = Vector2.ONE 
# for example

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	contact_monitor = true
	max_contacts_reported = 4


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if is_held and is_instance_valid(held_by):
		global_position = held_by.global_position + carry_offset

func pick_up(new_held_by: Node2D) -> bool:
	if is_held or not can_interact: return false
	
	is_held = true
	held_by = new_held_by
	freeze = true
	freeze_mode = RigidBody2D.FREEZE_MODE_KINEMATIC
	collision_detector.disabled = true
	return true

func drop() -> void:
	if not is_held: return
	
	is_held = false
	held_by = null
	freeze = false
	collision_detector.disabled = false

func _on_body_entered(body: Node) -> void: # touches another body
	if body is Bird:
		pass
	push_error("Interactable._on_body_entered() not implemented in %s. Define it!" % name)


func _on_zone_entered(area: Area2D) -> void: # touches a zone
	push_error("Interactable._on_zone_entered() not implemented in %s. Define it!" % name)


# bird needs to interact, by sending signal
