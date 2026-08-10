class_name BreakableInteractable
extends Interactable

## Can be picked up and breaks on contact with objects named break_on_name

## Can be picked up and dropped inherited from Interactable 
## Breaks on contact with objects named break_on_name

@export var break_on_name: String = ""
@export var velocity_needed: float = 10
@export var crack_sound: String = ""
@export var crack_index: int = 0
@export var no_crack_sound_fail: String = ""

@export var drop_on_break: PackedScene = null

var broken: bool = false;

func _on_body_entered(body: Node) -> void:
	super._on_body_entered(body) # MUST ADD THIS AT EVERY ON BODY ENTERED FUNCTION
	
	# If the body is named break_on_name
	if (not broken and not is_held and not break_on_name.is_empty() 
	and body.name.match(break_on_name)):
		_try_break_open(body)

func _on_zone_entered(_area: Area2D) -> void: # No functionality
	pass

func _try_break_open(body: Node) -> bool:
	# Checks if either this object or the object it's interacting with
	# are moving fast enough
	print("Linear velocity was %s" % linear_velocity.length())
	if linear_velocity.length() >= velocity_needed:
		_break_open()
		return true
	elif body is RigidBody2D and body.linear_velocity.length() >= velocity_needed:
		print("Linear velocity was %s" % body.linear_velocity.length())
		_break_open()
		return true
	else:
		if AudioController.has_method(no_crack_sound_fail):
			AudioController.call(no_crack_sound_fail)
	
	return false

# Controls the breaking open animation
func _break_open():
	if broken: return
	print("%s broke!" % name)
	broken = true
	set_deferred("freeze", true)
	set_deferred("position", position)
	$AnimatedSprite2D.play("Cracked")
	if AudioController.has_method(crack_sound):
		AudioController.call(crack_sound, crack_index)
	if drop_on_break != null:
		var object = drop_on_break.instantiate()
		object.position = position
		get_node("..").add_child(object) # Puts node on parent of this node

func _on_place_interactable_item_placed(interactor: Node2D, item: Interactable) -> void:
	if not broken:
		_break_open()
