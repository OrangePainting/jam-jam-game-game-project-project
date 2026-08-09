class_name Interactable extends RigidBody2D

## Base class for any interactable object 
## that can be pushed or picked up or any other general interaction

## For a specific object that has it's own features, just write "extends Interactable" at the top
## on body entered, and on zone entered are required functions
## on picked up and on dropped are optional functions to write

@export var can_interact: bool = true
@export var can_pick_up: bool = false

@export var carry_offset := Vector2(-60, 0)

@onready var zone_detector: Area2D = %ZoneDetection
@onready var collision_detector: Node2D = %InteractionDetection

var is_held: bool = false
var held_by: Node2D = null

signal interacted_with(interactor: Node2D)

# Linear velocity is already built into RigidBody2D, so we can just use
#   linear_velocity = Vector2.ONE 
# for example

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	contact_monitor = true
	max_contacts_reported = 4
	
	if collision_detector is not CollisionShape2D and collision_detector is not CollisionPolygon2D:
		push_error("collision_detector on %s is not a collision shape or polygon" % name)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	if is_held and is_instance_valid(held_by):
		# This is very janky code, but it works ONLY if the bird is holding the interactable
		global_position = held_by.global_position + carry_offset * (-1 if held_by.sprite.flip_h else 1)

# Used for picking up 
func pick_up(new_held_by: Node2D) -> bool:
	if is_held or not can_pick_up or not can_interact: return false
	
	is_held = true
	held_by = new_held_by
	freeze = true
	freeze_mode = RigidBody2D.FREEZE_MODE_KINEMATIC
	collision_detector.disabled = true
	interacted_with.emit(new_held_by)
	_on_picked_up()
	return true

func drop() -> void:
	if not is_held: return
	
	is_held = false
	held_by = null
	freeze = false
	collision_detector.disabled = false
	_on_dropped()

# Generic interact function that happens when can_pick_up is false
func interact(interactor: Node2D) -> bool:
	if not can_interact: return false
	
	interacted_with.emit(interactor)
	return true

## Override to react to being picked up
func _on_picked_up() -> void:
	pass

## Override to react to being dropped
func _on_dropped() -> void:
	pass

func _on_body_entered(_body: Node) -> void: # touches another body
	# either grass (outside) or concrete (inside)
	if _body.is_in_group("grass"):
		AudioController.play_item_dropped_on_grass_sound()
	if _body.is_in_group("concrete"):
		AudioController.play_item_dropped_on_generic_surface_sound()


func _on_zone_entered(_area: Area2D) -> void: # touches a zone
	push_error("Interactable._on_zone_entered() not implemented in %s. Define it!" % name)


# bird needs to interact, by sending signal
